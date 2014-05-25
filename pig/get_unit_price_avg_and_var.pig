register /homes/lucasmf/datafu-1.2.1-SNAPSHOT.jar;

define VAR datafu.pig.stats.VAR();

transactions = LOAD 'transactions.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:double, productmeasure:chararray, purchasequantity: double, purchaseamount: double);

transactions = FILTER transactions by user != 'id';

groupedTransactions = GROUP transactions BY (category, company, brand);

data = FOREACH groupedTransactions {
	unitPrice  = FOREACH transactions GENERATE (float)purchaseamount / (float)(productsize * purchasequantity);	
	generate FLATTEN(group), SUM(unitPrice) / COUNT(transactions), VAR(unitPrice);
}

STORE data INTO '/tmp/purchasedCountAvgUnitPriceVariance.csv' using PigStorage(',');