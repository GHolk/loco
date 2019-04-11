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
## @deftypefn {Function File} d2r (@var{DEGREE})
## @deftypefnx {Function File} d2r (@var{DEGREE}, @var{MINUTE}, @var{SECOND})
##   convert angle from degree to radius.
##   allow decimal degree or degree minute second format.
## @end deftypefn

## Author: gold holk <gholk@dt13>
## Created: 2019-04-11

function radius = d2r(degree, minute = 0, second = 0)
  radius = dms2d(degree, minute, second) / 180 * pi;
end
