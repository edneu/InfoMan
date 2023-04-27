## TAX Consolidation
select * from finance.trans_2022;
## DROP TABLE finance.trans_2022;

DROP TABLE IF EXISTS finance.summsrce;
Create table finance.summsrce AS 
SELECT	Source,
		Transaction_Type,
        Category,
        Entity,
        Sum(Amount) as Amount
From finance.trans_2022
where Category<>"OMIT"
GROUP BY  	Source,
			Transaction_Type,
			Category,
			Entity
Order BY 	Transaction_Type DESC,
			Category,
			Entity;    
         
/*
UPDATE finance.trans_2022
SET Amount=-1*Amount          
WHERE SOURCE="AirBnB";
*/         
         
DROP TABLE IF EXISTS finance.summcatent;
CREATE TABLE finance.summcatent AS              
SELECT	Transaction_Type,
        Category,
        Entity,
        Sum(Amount) as Amount
From finance.trans_2022
where Category<>"OMIT"
GROUP BY  	Transaction_Type ,
			Category,
			Entity
Order BY 	Transaction_Type DESC,
			Category,
			Entity;                      




DROP TABLE IF EXISTS finance.summcat;
CREATE TABLE finance.summcat AS              
SELECT	Transaction_Type,
        Category,
        Sum(Amount) as Amount
From finance.trans_2022
where Category<>"OMIT"
GROUP BY  	Transaction_Type,
			Category
			Order BY Transaction_Type DESC ,
			Category
			;   


UPDATE finance.trans_2022 Set Amount=Amount*-1 where Source='Paypal';
UPDATE finance.trans_2022 Set Amount=Amount*-1 where Source='AirBnB';