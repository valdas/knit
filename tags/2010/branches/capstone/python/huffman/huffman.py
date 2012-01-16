def huffman(tree):
    test = sorted(tree)
    for i in range(len(tree)-1):
        for j in range(len(tree)):
            if tree[j][2] in test[0][2]:
                tree[j] = (tree[j][0],'0'+tree[j][1],tree[j][2])
            elif tree[j][2] in test[1][2]:
                tree[j] = (tree[j][0],'1'+tree[j][1],tree[j][2])
        test[0] = (test[0][0]+test[1][0],'',test[0][2]+test[1][2])
        del test[1]
        test = sorted(test)
    return tree
