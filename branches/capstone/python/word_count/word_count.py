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
