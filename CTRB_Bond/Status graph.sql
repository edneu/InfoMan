

select * from space.status;

drop table if exists space.statussumm;
create table space.statussumm as
Select Completeion_Date,
		Sum(Completed_Survey) AS PIs_Compelted,
        max(Total_Investigators) as PIs_Surveyed,
        SUM(Number_of_Projects) as Projects_Collected,
        max(Total_Projects) AS Projects_to_Collect
from space.status
group by Completeion_Date
order by Completeion_Date;