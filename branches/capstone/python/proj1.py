# Zach Cowell
# CS 210
# Project 1
# Submitted May 29, 2009
# proj1.py

class circular_buffer():
	str=""
	thin=""
	size=0
	def __init__(self,len):
		self.size=len
		self.flush()

	def append(self, x):
		if (len(x) <= self.size):
			self.remove(len(x))
			self.str+=x
		else:
			self.str=x
			self.remove(len(x)-self.size)
	
	def flush(self):
		strN=""
		for i in range(self.size): 
			strN+= " "
		self.str=strN
		
	def display(self):
		return self.str
		
	def grow(self,num):
		if (num >= 0):
			for x in range(num):
				self.str=" " + self.str
			self.size+=num
		else: # The value is negative, so instead I will shrink buffer
			print "Warning! Negative value passed. Shrinking buffer."
			self.shrink(-1 * num)
		
	def shrink(self, num):
		strN = ""
		if (num <= self.size):
			if (num >= 0):
				self.size-=num
				self.str = self.str[num:]
			else: # The value is < 0, so instead I will grow buffer
				print "Warning! Negative value passed. Growing buffer"
				self.grow(-1*num)
		else:
			print "Size specified is too large for this buffer. Aborting."

	def remove(self, x):
		strN=self.str[x:]
		self.str=strN		
