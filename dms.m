#!/usr/bin/env octave

## Author: c34031328 c34031328@mail.ncku.edu.tw
## Created: 2016-03-15
## copyleft
## 
## input 

function [ddd] = dms (d, m, s, ds)

sss = (d*60 + m)*60 + s; 

if exist('ds')
ddd = sss; 
else
ddd = sss/3600;
endif

#ddd = d + ( m + s/60 )/60 ;

endfunction
