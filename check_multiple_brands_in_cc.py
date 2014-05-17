from Transaction import *
from itertools import *

transactions_filename = 'data/transactions.csv'

transactions = []
for e, line in enumerate(open(transactions_filename, 'r')):	
	if e == 0:
		continue	
	if e > 100000:
		break
	transactions.append(Transaction(line))	

sorted_transactions = sorted(transactions, key = lambda transaction: (transaction.company + '_' + transaction.category))

for key, values in groupby(sorted_transactions, lambda transaction: (transaction.company + '_' + transaction.category)):
	print key + ': ',
	print len(set(map(lambda transaction: (transaction.brand), values)))