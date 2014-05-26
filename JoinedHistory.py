class JoinedHistory:
	"""docstring for History"""
	def __init__(self, line):		
		values = line.split(',')
		self.user = values[0]
		self.company = values[1]
		self.category = values[2]
		self.brand = values[3]
		self.chain = values[4]		
		self.market = values[5]
		self.repeattrips = values[6]
		self.repeater = values[7]
		self.offerdate = values[8]
		self.quantity = values[9]
		self.offervalue = values[10]
		
	@classmethod
	def getHistories(cls,count = 100, filename = 'data/joinedTrainHistory.csv'):

		histories = []
		for e, line in enumerate(open(filename, 'r')):
			if(e == 0):
				continue
			if(e > count):
				break
			histories.append(History(line))
		return histories

	

