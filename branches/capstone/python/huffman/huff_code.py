from huffman import *

letters = {}
tree = []
temp = []

L = raw_input('Enter text you wish to be encoded: ')

for i in L:
    try:
        letters[i] += 1
    except KeyError:
        letters[i] = 1

for j in letters.keys():
    temp.append((letters[j],'',j))

tree = sorted(huffman(temp))

print tree
