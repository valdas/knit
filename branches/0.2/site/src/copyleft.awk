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

#copyleft

#Prints the GNU license.

#Example
#=======

#(KNIT programmers can run this example using _cd quill;make eg14_).

#Input...

#  s2a("What,gizmo,Why,A wonderful thing,When,2010,Who,Tim Menzies",Opt);
#  copyleft() 

#Output...

#  gizmo : A wonderful thing
#  Copyright 2010 by Tim Menzies (GPL version 3)

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#Code
#====

#Globals
#-------

#This code assumes that the `Opt` array has fields for _What_, _Why_, _When_, _Who.

#Main
#----

 function copyleft() {
    about();
    print ""
    print "This program is free software: you can redistribute it and/or modify"
    print "it under the terms of the GNU General Public License as published by"
    print "the Free Software Foundation, either version 3 of the License, or"
    print "(at your option) any later version."
    print ""
    print "This program is distributed in the hope that it will be useful,"
    print "but WITHOUT ANY WARRANTY; without even the implied warranty of"
    print "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
    print "GNU General Public License for more details."
    print ""
    print "You should have received a copy of the GNU General Public License"
    print "along with this program.  If not, see <http://www.gnu.org/licenses/>."
    print ""
 }
 function about() {
    print Opt["What"] " : " Opt["Why"];
    print "Copyright " Opt["When"] " by " Opt["Who"] " (GPL version 3)";
 }

#Author
#======
#Tim Menzies

