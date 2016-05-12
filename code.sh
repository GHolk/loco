#!/bin/sh
sed '/^\t*\.EQ/,/^\t*\.EN/s/\t//g' |\
preconv -e utf-8 | eqn -T MathML |\
sed 's/\\\[u\(....\)\]/\\u\1/g;/^.E[QN]$/d;1d' |\
xargs -0 printf "%b"
