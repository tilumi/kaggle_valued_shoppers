register /homes/lucasmf/datafu-1.2.1-SNAPSHOT.jar;

define VAR datafu.pig.stats.VAR();

transactions = LOAD 'transactions_test.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:int, productmeasure:chararray, purchasequantity: int, purchaseamount: int);

groupedTransactions = GROUP transactions BY (category, company, brand);

data = FOREACH groupedTransactions {
	unitPrice  = FOREACH transactions GENERATE (float)purchaseamount / (float)(productsize * purchasequantity);	
	generate FLATTEN(group), COUNT(transactions), SUM(unitPrice), VAR(unitPrice);
}

dump data;