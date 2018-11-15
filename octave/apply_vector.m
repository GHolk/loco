## Copyright (C) 2018 gold holk
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
## @deftypefn {Function File} {@var{result} =} apply_vector (@var{f}, @var{v})
##   apply each element of vector @var{v} as argument to function @var{f} .
## @end deftypefn

## Author: gold holk <gholk@dt13>
## Created: 2018-10-15

function result = apply_vector (f, v)
  cell = num2cell(v);
  result = f(cell{:});
end
