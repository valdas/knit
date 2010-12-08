#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Casey Corder
# CS210 LAB
#
# word_count.py
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


def word_count(L):
    test = {}
    for i in L:
        try:
            if test[i] > 0:
                test[i] += 1
        except KeyError:
            test[i] = 1
    return test

i = 0
a = []
f = open('tests/tmp/infile','r')
for line in f:
        a.append(line)
f.close()

f = open('tests/tmp/outfile','w')
s = word_count(int(a[0]))
f.write(str(s))
