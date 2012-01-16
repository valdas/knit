#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Casey Corder
#
# fib.py
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def fib(n):
	if n==0:
		return 0
	elif n==1:
		return 1
	else:
		return fib(n-1) + fib(n-2)

i = 0
a = []
f = open('tests/tmp/infile','r')
for line in f:
        a.append(line)
f.close()

f = open('tests/tmp/outfile','w')
s = fib(int(a[0]))
f.write(str(s))
