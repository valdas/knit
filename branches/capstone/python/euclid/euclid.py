#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Casey Corder
#
# euclid.py
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def euclid(a,b):

	if b==0:
		return a
	else:
		return euclid(b,(a%b))

i = 0
a = []
f = open('/tests/tmp/infile','r')
for line in f:
        a.append(line)
f.close()

f = open('/tests/tmp/outfile','w')
s = euclid(int(a[0]),int(a[1]))
f.write(str(s))

