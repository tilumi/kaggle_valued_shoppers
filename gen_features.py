from Transaction import *
from itertools import groupby
from collections import Callable
import sys


transactions = Transaction.getTransactions(
    count=sys.maxint, filename='data/reducedTransactions.csv')

class GetGroupKeyStrFunc(Callable):

    def __init__(self, group_keys):
        self.group_keys = group_keys

    def __call__(self, transaction):
        group_keys_str = ''
        for group_key in self.group_keys:        	                            
        	group_keys_str += getattr(transaction, group_key)
        	group_keys_str += '_'              
        return group_keys_str[0:-2]

class FeatureGenerator:

    def __init__(self, group_keys, output_filename):
        self.output_filename = output_filename
        self.get_group_key_str_func = GetGroupKeyStrFunc(group_keys)

    def generateFeatures(self,transactions):
    	f = open(self.output_filename,'w')
        ordered_transactions = sorted(
            transactions, key=self.get_group_key_str_func)                        	        
        for group_keys_str, group in groupby(ordered_transactions, key=self.get_group_key_str_func):
        	sum = 0
        	for transaction in group:
        		sum += float(transaction.purchasequantity) * float(transaction.productsize)        	
        	key_tokens = group_keys_str.split('_')
        	output = ''
        	for key_token in key_tokens:
        		if not key_token:
        			output += '0'
        		else:
        			output += key_token
        		output += ','        
        	output += str(sum)        	
        	f.write(output + '\n')
        f.close()

FeatureGenerator(['user','company'],'data/purchasedCountByCompany.csv').generateFeatures(transactions)
FeatureGenerator(['user','company','brand'],'data/purchasedCountByCompanyAndBrand.csv').generateFeatures(transactions)
FeatureGenerator(['user','company','category'],'data/purchasedCountByCompanyAndCategory.csv').generateFeatures(transactions)
FeatureGenerator(['user','company','category','brand'],'data/purchasedCountByItem.csv').generateFeatures(transactions)