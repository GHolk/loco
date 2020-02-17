function c = count_outside(data, power)
    m = mean(data);
    s = std(data, 1) * power;
    c = 0;
    for x = data
        res = x - m;
        if (abs(res) > s)
            c += 1;
        endif
    endfor
endfunction


function clean = filter_stdev(data, power = 3)
    d = std(data(:,2), 0) * power;
    m = mean(data(:,2));
    clone = zeros(size(data));
    index = 1;
    for i = 1:length(data)
        if (abs(data(i) - m) < d)
            clone(index) = data(i);
            index += 1;
        end
    end
    clean = resize(clone, [index-1, 1]);
end

function clean = keep_wash(data, power = 3)
    clean = filter_stdev(data, power);
    reduce_count = length(data) - length(clean)
    while (reduce_count > 0)
        data = clean;
        clean = filter_stdev(data, power);
        reduce_count = length(data) - length(clean)
    end
end

