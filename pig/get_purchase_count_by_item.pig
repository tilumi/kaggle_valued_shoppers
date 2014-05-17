transactions = LOAD 'transactions_test.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:int, productmeasure:chararray, purchasequantity: int, purchaseamount: int);

groupedTransactions = GROUP transactions BY (user, company, category, brand);

result = FOREACH groupedTransactions {
		total = FOREACH  transactions GENERATE purchasequantity * productsize;
		GENERATE FLATTEN(group), COUNT(transactions), SUM(total);
} 

DUMP result;