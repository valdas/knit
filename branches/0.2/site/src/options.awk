## -*- mode: Awk; -*-  vim: set filetype=awk : 
#@uses copyleft barph s2a

#options

#Reads flags from the command line.

#Assumes that there exists a function, defined elsewhere, called _help()_,
#_copyright()_ and _about()_.

 function opt(x) {
     return (x in Opt) ? Opt[x] : barph(Opt["What"] " option ["x"] unknown")
 }
 function ok2go(opt,str) { # returns 0 if bad options
     s2a("a=;c=;h=;" str,opt,"[=;]")
     ARGC = options(opt,ARGV,ARGC)
     if (opt("c")) exit copyleft();
     if (opt("a")) exit about();    
     if (opt("h")) exit help();
     return 1
 }
 function options(opt,input,n,  key,i,j,k,tmp) {
     for(i=1;i<=n;i++)  { # 1: explore argstill no more flags
	 key = input[i]
	 if (sub(/^[-]+/,"",key))  { # 1a: we have a new flag
	     if (key in opt)         # 1b: if legal flag, change its value
		 # 1c: if upper case flag grab value from command line 
		 opt[key] = (key ~ /^[A-Z]/) ? input[++i] : 1
	     else barph("-"key" unknown. Try -h for help.")
	 } else { i--; break }
     }
     for(j=i+1;j<=n;j++)  # 2: clear the flags from n, input 
	 tmp[j-i]=input[j]
     split("",input,"")
     for(k in tmp) 
	 input[k] = tmp[k]
     n -= i
     return n
 }
