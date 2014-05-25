class History:
	"""docstring for History"""
	def __init__(self, line):		
		values = line.split(',')
		self.user = values[0]
		self.chain = values[1]
		self.offer = values[2]
		self.market = values[3]
		self.repeattrips = values[4]
		self.repeater = values[5]
		self.offerdate = values[6]
		
	@classmethod
	def getHistories(cls,count = 100, filename = 'data/trainHistory.csv'):

		histories = []
		for e, line in enumerate(open(filename, 'r')):
			if(e == 0):
				continue
			if(e > count):
				break
			histories.append(History(line))
		return histories