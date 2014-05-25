class Transaction:	
	def __init__(self, line):		
		values = line.split(',')
		self.user = values[0]
		self.chain = values[1]
		self.dept = values[2]
		self.category = values[3]
		self.company = values[4]
		self.brand = values[5]
		self.date = values[6]
		self.productsize = values[7]
		self.productmeasure = values[8]
		self.purchasequantity = values[9]
		self.purchaseamount = values[10]

	@classmethod
	def getTransactions(cls,count = 100, filename = 'data/transactions.csv'):

		filename = 'data/transactions.csv'

		transactions = []
		for e, line in enumerate(open(filename, 'r')):
			if(e == 0):
				continue
			if(e > count):
				break
			transactions.append(Transaction(line))
		return transactions