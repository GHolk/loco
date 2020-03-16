#!/bin/sh

# --embed make stand alone single html file
# --math-output use mathjax, but can not embed
# --extensions enable table code-block extension

darkslide --embed \
          --extensions=tables,fenced_code,mdx_truly_sane_lists \
          "$@" # --math-output
