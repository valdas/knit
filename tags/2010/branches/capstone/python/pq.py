# Zach Cowell
# Project 2, part 1
# CS 210
# June 10

class priority_queue:

#__init__() to initialize the priority queue to empty
#.enqueue(v, p) to add an element with value v and priority p
#.Enqueue(V, p) to enqueue all of the elements in the list V in order, all with priority p
#.dequeue() to return the value of the front element and remove it
#.peek() to return the value of the front element without removing it
#.rotate(n) to force the front element to the back of the list, changing its priority minimally; 	do that n times, where n must be between one and the size of the queue minus one.
#.abandon(n) to get rid of the n lowest-priority elements from the back of the queue
#.interval() to return the interval of priorities as a tuple of the form (low, high)

	def __init__(self):
		self.size = 0
		self.q = []

	def rotate(self, n):
		if (n > self.size-1) | (n < 1):
			print 'Invalid value input. Please give a value of between 1 and ' + str(self.size-1)
		else:
			p = self.q[self.size-1][1]
			for i in range(n):
				self.q = self.q[1:] + [( self.q[0][0],p)]

	def enqueue(self, v, p):
		low = 0        
		high = self.size
		while high > low:
			mid = (low+high)/2
			if p < self.q[mid][1]: high = mid
			else: low = mid+1
		self.q= self.q[:low] + [(v,p)] + self.q[low:]
		self.size+=1

	def Enqueue(self, V, p):
		low = 0        
		high = self.size
		while high > low:
			mid = (low+high)/2
			if p < self.q[mid][1]: high = mid
			else: low = mid+1
		for x in range(len(V)):
			self.enqueue(V[x],p)
		
	def interval(self):
		low = self.q[0][1]
		high = self.q[self.size-1][1]
		toopers = (low,high)
		
		return toopers
		
	def abandon(self,n):
		
		if (n > self.size):
			print 'Error: Specified value is too high, please choose a number that is not larger than size' + str(self.size)
		else:
			self.q = self.q[n:]
			self.size-=n
		
	def dequeue(self):
		if self.size == 0:
			return None
		else:
			self.size-=1
			temp = self.q[0]
			self.q= self.q[1:]
			return temp
		
	def peek(self):
		return self.q[0]
		
	def disp(self):
		return self.q