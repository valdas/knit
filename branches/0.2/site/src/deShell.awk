## -*- mode: Awk; -*-  vim: set filetype=awk : 

#deShell

#Prune characters that cause shell exection.

 function deShell(str) {
     gsub(/["`\$;\|&><]/,"",str);
     return str
 }

#by Tim Menzies

