BEGIN { _ = SUBSEP }

function round(x)   { return int(x + 0.5) }
function max(n1,n2) { return n1<n2 ? n2 : n1 }
function min(n1,n2) { return n1<n2 ? n1 : n2 }
function within(n,min,max) { 
	if (n < min)
		return min
	if (n > max)
		return max
	return n
}
function shuffle(a,n,  i,j,tmp) {
  for(i=1;i<=n;i++) {
    j=i+round(rand()*(n-i));
    tmp=a[j];
    a[j]=a[i];
    a[i]=tmp;
  };
  return n;
}

function o(a,s,   b,c,m,n,key,val,i,j,tmp,sep) {
	print ""
	m     = asorti(a,b)
	for(i=1;i<=m;i++)  {
		key=b[i]
		val=a[b[i]]
		printf("%s",  sep s "["  )
		n=split(key,tmp,_)
		c = ""
		for(j=1;j<=n;j++)	{	
			printf("%s", c tmp[j]  )
			c=","
		}
		printf("%s", "]=" val )
		sep="\n";
	};
	print ""
}
