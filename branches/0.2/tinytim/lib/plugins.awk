# -*- mode: Awk; -*-  vim: set filetype=awk : 
#
# This file is part of KNIT; copyright (C) 2010 by Tim Menzies
# tim@menzies.us.
#
# KNIT is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# KNIT is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with KNIT.  If not, see <http://www.gnu.org/licenses/>.

function slotsPlugIns(str,slots,   tmp) {
    split(str,tmp,";")
    if (tmp[1]=="quotes")
        return quotes(slots["quotes"])
    return str
}
function quotes(q,    n,tmp) {
    srand(systime() + PROCINFO["pid"])
    n=split(q,tmp,"\n")
    return tmp[int(rand()*n) + 1]
}
