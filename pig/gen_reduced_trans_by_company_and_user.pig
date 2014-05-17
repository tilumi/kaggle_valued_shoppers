transactions = LOAD 'transactions.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:chararray, productmeasure:chararray, purchasequantity: chararray, purchaseamount: chararray);

trainHistory = LOAD 'trainHistory.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, offer:chararray, market:chararray, repeattrips:chararray, repeater: chararray, offerdate: chararray);

testHistory = LOAD 'testHistory.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, offer:chararray, market:chararray, offerdate: chararray);

offers = LOAD 'offers.csv' USING  PigStorage(',') AS (offer: chararray, category:chararray, quantity:chararray, company:chararray, offervalue:chararray, brand:chararray); 

trainHistory = JOIN trainHistory BY offer, offers BY offer;

testHistory = JOIN testHistory BY offer, offers By offer;

transactionsAppearInTrainHistory = JOIN transactions BY (user, company), trainHistory BY (user, company);

transactionsAppearInTestHistory = JOIN transactions BY (user, company), testHistory BY (user, company);

transactionsAppearInTrainHistory = FOREACH transactionsAppearInTrainHistory GENERATE transactions::user, transactions::chain, transactions::dept, transactions::category, transactions::company, transactions::brand, transactions::date, transactions::productsize, transactions::productmeasure, transactions::purchasequantity, transactions::purchaseamount;

transactionsAppearInTestHistory = FOREACH transactionsAppearInTestHistory GENERATE transactions::user, transactions::chain, transactions::dept, transactions::category, transactions::company, transactions::brand, transactions::date, transactions::productsize, transactions::productmeasure, transactions::purchasequantity, transactions::purchaseamount;

reducedTransactions = UNION transactionsAppearInTrainHistory, transactionsAppearInTestHistory;

STORE reducedTransactions INTO 'reducedTransactions.csv' using PigStorage(',','-schema');;