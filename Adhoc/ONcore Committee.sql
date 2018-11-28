
########################################################################
######### ONCORE BASED - Review and Closed Study Summaries

select * from oncore.reviewedstudies;


SELECT SUMMARY4_REPORT_TYPE, CLOSED_TO_ACCRUAL_REASON
from oncore.reviews2
WHERE PRMC_REVIEW_REASON="Continuation Review";

select min(PRMC_ACTION_DATE), Max(PRMC_ACTION_DATE) from oncore.reviews2;

select PRMC_REVIEW_REASON,SUMMARY4_REPORT_TYPE, count(*) as NumReviews
from oncore.reviews2
group by PRMC_REVIEW_REASON,SUMMARY4_REPORT_TYPE;

select CLOSED_TO_ACCRUAL_REASON, count(DISTINCT PROTOCOL_NO) as NumReviews
from oncore.reviews2
group by CLOSED_TO_ACCRUAL_REASON;



select Distinct PRMC_COMMENTS, count(DISTINCT PROTOCOL_NO) as NumReviews
from oncore.reviews2
group by PRMC_COMMENTS;


select  CLOSED_TO_ACCRUAL_COMMENTS, count(DISTINCT PROTOCOL_NO) as NumReviews
from oncore.reviews2
WHERE CLOSED_TO_ACCRUAL_REASON="Other"
group by CLOSED_TO_ACCRUAL_COMMENTS;

create table work.oncore1 as
select * from oncore.reviews2 WHERE CLOSED_TO_ACCRUAL_REASON="Other";



