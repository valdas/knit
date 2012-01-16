d = {'z':4, 'x':7, 'y':13, 'nineteen':19}
f=open('output.txt', 'w')
for i in d:
	f.write(str(i) +'\0'+ str(d[i]) + '\n' )
f.close()

f=open('output.txt', 'r')

x = {}

k = f.readline()
while k:
	splitter = k.split('\0')
	x[splitter[0].strip()] = splitter[1].strip()
	k = f.readline()
f.close()

print x
