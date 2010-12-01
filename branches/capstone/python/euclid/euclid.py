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
f = open('tests/test1.in','r')
for line in f:
        a.append(line)
f.close()

f = open('tests/tmp/test1.out','w')
s = euclid(int(a[0]),int(a[1]))
f.write(str(s))

