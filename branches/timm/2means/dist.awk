function main(    zero,c1,c2) {
	zero = round(Data["rows"] * rand())
	zero = within(zero,1,Data["rows"])
	c1 = furthest(zero)
	c2 = furthest(c1)
	print " zero " zero " c1 " c1 " c2 " c2
}
function d(r1,r2,  out) {
	if (r1 > r2)
		return d(r2,r1)
	if  ((r1,r2) in D)
		out = D[r1,r2] 
	else {
		out = d1(r1,r2,Data["cols"])
		D[r1,r2] = out
	}
	return out
}
function d1(r1,r2,cols, sum,col) {
	for(col=1;col<=cols;col++) 
		if (col in Discretes)
			sum += (Data[r1,col] != Data[r2,col])
        else
			sum += (Data[r1,col] - Data[r2,col])^2
	return (sum^0.5)/(cols^0.5)
}
function furthest(r1,   rmax,r2,tmp,max) {
	rmax=Data["rows"]
	max = -1 
	out = 1
	for(r2=1;r2<=rmax;r2++)  
		if (r1 != r2)
			if( (tmp= d(r1,r2)) > max ) {
				max = tmp
				out = r2
			}
	return out
}
END{
	srand(Seed ? Seed : 1)
	main() 
	}
