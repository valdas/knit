BEGIN {
	s2a("a,about,h,help,u,usage",A,",")
	for(I in A)
		print I " " A[I]
}
