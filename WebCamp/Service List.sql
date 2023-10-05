
Drop table if exists ctsi_webcamp_adhoc.SvcList;
create table ctsi_webcamp_adhoc.SvcList AS
SELECT  cs.labtest,
        lu.labtest AS Service,
		count(distinct cs.PROTOCOL) as nPROTOCOLS,
        count(*) as nCompletedServices,
        Count(distinct OPVISIT) as nOPvisits,
        COUNT(distinct ADMISSIO) as nIPAdmissions,
        COUNT(distinct SBADMISSIO) as nSBAdmissions
FROM ctsi_webcamp_pr.coreservice cs LEFT JOIN ctsi_webcamp_pr.labtest lu
ON cs.labtest=lu.UNIQUEFIELD
WHERE cs.STATUS=2
AND cs.STARTDATE>=str_to_date('09,01,2022','%m,%d,%Y')
GROUP BY cs.Labtest,lu.labtest;


