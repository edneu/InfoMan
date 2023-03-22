## TAX Consolidation
select * from finance.trans_2022;
## DROP TABLE finance.trans_2022;


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
Order BY 	Transaction_Type,
			Category,
			Entity;    
         
            
SELECT	Transaction_Type,
        Category,
        Entity,
        Sum(Amount) as Amount
From finance.trans_2022
where Category<>"OMIT"
GROUP BY  	Transaction_Type,
			Category,
			Entity
Order BY 	Transaction_Type,
			Category,
			Entity;                      


UPDATE finance.trans_2022 Set Amount=Amount*-1 where Source='Paypal';
UPDATE finance.trans_2022 Set Amount=Amount*-1 where Source='AirBnB';