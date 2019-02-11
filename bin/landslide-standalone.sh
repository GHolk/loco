#!/bin/sh

# --embed make stand alone single html file
# --math-output use mathjax, but can not embed
# --extensions enable table code-block extension

landslide --embed --extensions=tables,fenced_code "$@" # --math-output
