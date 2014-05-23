transactions = LOAD 'reducedTransactions.csv/*' USING PigStorage(',','-schema') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:int, productmeasure:chararray, purchasequantity: int, purchaseamount: int);

groupedTransactions = GROUP transactions BY (user, company, brand);

result = FOREACH groupedTransactions {
		total = FOREACH  transactions GENERATE purchasequantity * productsize;
		GENERATE FLATTEN(group), COUNT(transactions), SUM(total);
} 

STORE result INTO 'purchasedCountByCompanyBrand.csv' using PigStorage(',','-schema');;