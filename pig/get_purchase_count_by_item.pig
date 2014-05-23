transactions = LOAD 'reducedTransactions.csv/*' USING PigStorage(',','-schema') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:double, productmeasure:chararray, purchasequantity: double, purchaseamount: double);

transactions = FILTER transactions by user != 'id';

groupedTransactions = GROUP transactions BY (user, company, category, brand);

result = FOREACH groupedTransactions {
		total = FOREACH  transactions GENERATE purchasequantity * productsize;
		GENERATE FLATTEN(group), COUNT(transactions), SUM(total);
} 

STORE result INTO 'purchasedCountByItem.csv' using PigStorage(',','-schema');;