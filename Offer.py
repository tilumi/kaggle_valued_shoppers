class Offer:
	def __init__(self, line):			
		values = line.split(',')
		self.offer = values[0]
		self.category = values[1]
		self.quantity = values[2]
		self.company = values[3]
		self.offervalue = values[4]
		self.brand = values[5]
		