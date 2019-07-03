#!/usr/bin/awk -f

function print_help() {
    printf("\
usage: cat value-list | [ power=power_of_test ] %s \n\
\n\
value-list could be line separated numeric data,\n\
with single column each line, or being 2 column each line.\n\
if file has only single column, data is auto indexed with line number.\n\
else the first and second column treated as key and value.\n\
\n\
this script will compute mean, standard deviation,\n\
and some other properties of all data.\n\
also it set column outside power_of_test times stdev enpty,\n\
then recompute stdev and remove outlier iteratively.\n\
\n\
power of test is set to 2.5 default.\n\
", "this_script", "this_script")
}

BEGIN {
    if (ENVIRON["power"] != "") power = ENVIRON["power"]
    else power = 2.5
}

(NR == 1) {
    if (NF <= 1) with_key = 0
    else if (NF >= 2) with_key = 1
    else {
        print_help()
        exit 1
    }
}

{
    if (with_key) table[$1] = $2
    else table[NR] = $1
}

END {
    if (NR == 0) {
        print_help()
        exit 1
    }
    
    copy_array()
    iterate_count = 0
    remove_total = 0
    do {
        m = mean()
        s = stdev(m)
        remove_count = remove_outside_gate(m, s*power)
        remove_total += remove_count
        iterate_count += 1
    }
    while (remove_count > 0)

    for (key in table) {
        if (key in copy) print key, copy[key]
        else print key
    }
    print "---"
    print "count", NR
    print "remove", remove_total
    print "iterate", iterate_count
    print_min_max_sum() 
    # print "mean", m
    printf("mean%s%.10f\n", OFS, m)
    # print "stdev", s
    printf("stdev%s%.10f\n", OFS, s)
}

function print_min_max_sum() {
    min = $(NF)
    max = min
    sum = 0
    for (key in copy) {
        value = copy[key]
        if (value > max) max = value
        if (value < min) min = value
        sum += value
    }
    print "min", min
    print "max", max
    print "sum", sum
}

function copy_array() {
    for (key in table) {
        if (table[key] != "") copy[key] = table[key]
    }
}

function mean() {
    m = 0
    count = 0
    for (i in copy) {
        m = m * count/(count+1) + copy[i] / (count+1)
        count += 1
    }
    return m
}

function stdev(mean) {
    square_sum = 0
    count = 0
    for (i in copy) {
        square_sum += square(copy[i] - mean)
        count += 1
    }
    return sqrt(square_sum / count)
}

function square(n) {
    return n*n
}

function remove_outside_gate(mean, gate) {
    count = 0
    for (i in copy) {
        if (abs(copy[i] - mean) > gate) {
            delete copy[i]
            count += 1
        }
    }
    return count
}

function abs(number) {
    if (number < 0) return -number
    else return number
}
