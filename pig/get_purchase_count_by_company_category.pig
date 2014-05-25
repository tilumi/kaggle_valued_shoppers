transactions = LOAD 'transactions.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:double, productmeasure:chararray, purchasequantity: double, purchaseamount: double);

transactions = FILTER transactions by user != 'id';

groupedTransactions = GROUP transactions BY (user, company, category);

result = FOREACH groupedTransactions {
		total = FOREACH  transactions GENERATE purchasequantity * productsize;
		GENERATE FLATTEN(group), COUNT(transactions), SUM(total);
} 

STORE result INTO 'purchasedCountByCompanyCategory.csv' using PigStorage(',','-schema');;