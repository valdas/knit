


function slurp(com,sep) { 
  RS=""; FS=sep ; com | getline; close(com) 
}
