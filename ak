#!/usr/bin/awk -E

BEGIN {
FS = "\t"
print "<aside>", "<ul>"
}

{
print $0
}

END {
print "</ul>", "</aside>"

}

