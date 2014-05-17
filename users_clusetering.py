from sklearn.cluster import KMeans

transactions_filename = 'data/transactions.csv'
train_data = []

with open(transactions_filename) as transactions_file:
	for line in transactions_file:
		fields = line.split(',')
		train_data.append([fields[3],fields[4],fields[5], fields[9], fields[10]])