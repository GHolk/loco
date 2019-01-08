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
## @deftypefn {Function File} {@var{dydx} =} derive_at (@var{f}, @var{x})
## @deftypefnx {Function File} {@var{dydx} =} derive_at (@var{f}, @var{x}, @var{dx})
##   compute the derive by (f(x+dx) - f(x-dx)) / 2 at x .
##   return a slope of f at x .
##   default interval is 0.005 .
## @end deftypefn

## Author: gold holk <gholk@dt13>
## Created: 2018-10-15

function dydx = derive_at (f, x, dx = 0.005)
  dydx = ( f(x.+dx) .- f(x.-dx) ) / (dx*2);
end
