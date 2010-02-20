## -*- mode: Awk; -*-  vim: set filetype=awk : 
##
## This file is part of KNIT; copyright (C) 2010 by Tim Menzies
## tim@menzies.us.
##
## KNIT is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## KNIT is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with KNIT.  If not, see <http://www.gnu.org/licenses/>.

#default

#Sets default values.

 function default(value, d) {
	 return value=="" ? d: value
 }

#by Tim Menzies

