## -*- mode: Awk; -*-  vim: set filetype=awk : 

#noShellComs

#Prune characters that cause shell exection.

 function deShell(str) {
     gsub(/["`\$;\|&><]/,"",str);
     return str
 }

#by Tim Menzies

