#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Casey Corder
# CS210 LAB
#
# palidrome.py
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def palidrome(text):
    if len(text) % 2 == 0:
        for i in range(len(text)/2):
            if text[i] != text[-i-1]: return False
    else:
        for i in range((len(text)-1)/2):
            if text[i] != text[-i-1]: return False
    return True

i = 0
a = []
f = open('tests/tmp/infile','r')
for line in f:
        a.append(line)
f.close()

f = open('tests/tmp/outfile','w')
s = palidrome(a[0])
f.write(str(s))
