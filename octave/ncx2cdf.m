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
## @deftypefn {Function File} ncx2cdf (@var{X}, @var{N}, @var{LAMBDA})
## @deftypefnx {Function File} ncx2cdf (@dots{}, @var{TERM})
##   compute the non-central chi square
##   cumulative probalitity density function
##   at @var{X} , degree of freedom @var{N} ,
##   and non-centrality parameter @var{LAMBDA} .
##
##   @var{TERM} is the term number of series, default is 32.
##   
## @end deftypefn

## Author: gold holk <gholk@dt13>
## Created: 2018-10-25

function f = ncx2cdf(x, n, lambda, term = 32)
  pdf = @(x) ncx2pdf(x, n, lambda, term);
  f = arrayfun(@(bound) quad(pdf, 0, bound), x);
end
