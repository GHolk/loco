#!/usr/bin/env octave
## Copyright (C) 2016 c34031328
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} d2d (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: c34031328 c34031328@mail.ncku.edu.tw
## Created: 2016-03-15

function [ddd] = dms (d, m, s)

ddd = d + ( m + s/60 )/60 ;

endfunction
