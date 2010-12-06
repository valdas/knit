# Zach Cowell
# CS 210
# Project 1 Part 2
# Submitted May 29, 2009
# addm.py

class proj12():
	m1=[]
	m2=[]
	m3=[]
	def __init__(self, m, n):
		self.m1=m
		self.m2=n
		
	def add_matrices(self):
		colsX = len(self.m1)
		colsY = len(self.m2)
		rowsX = len(self.m1[0])
		rowsY = len(self.m2[0])
		self.m3=[[0 for i in range(rowsX)] for j in range(colsX)]
		
		
		if (rowsX == rowsY) & (colsX == colsY):
			for i in range(colsX):
				for j in range(rowsX):
					self.m3[i][j] = self.m1[i][j] + self.m2[i][j]
			print "Key:" 
			print "Matrix 1"
			print "Matrix 2"
			print "Resulting matrix when added together"
			print self.m1
			print self.m2
			print self.m3
		else:
			print "Matrix dimensions are not correct. Aborting."