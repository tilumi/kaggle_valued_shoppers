register /homes/lucasmf/datafu-pig-1.2.1-core.jar;

define Entropy datafu.pig.stats.entropy.Entropy();

transactions = LOAD 'transactions.csv' USING PigStorage(',') AS (user:chararray, chain:chararray, dept:chararray, category:chararray, company:chararray, brand: chararray, date: chararray, productsize:double, productmeasure:chararray, purchasequantity: double, purchaseamount: double);

transactions = FILTER transactions by user != 'id';

groupedTransactions = GROUP transactions BY (user, category, company, brand);

purchased_count = FOREACH groupedTransactions GENERATE  group.user, group.category, COUNT($1) AS purchased_count;

grouped_purchased_count_by_user_category = GROUP purchased_count BY (user,category);


result = FOREACH grouped_purchased_count_by_user_category {
	purchased_count = ORDER purchased_count BY purchased_count;
    purchased_count_ordered = purchased_count.purchased_count;    
    GENERATE FLATTEN(group), Entropy(purchased_count_ordered);  
}

STORE result INTO 'purchasedEntropyByCategory.csv' using PigStorage(',','-schema');;