
######################################################################################################################
######################################################################################################################
##  WEBCAMP PRICING TABLE For MATT ALDAY 7/7/2020 - 7/13/2020
######################################################################################################################
######################################################################################################################
######################################################################################################################
######### ID OPVISITS FOR PRICING

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.OPV;
CREATE TABLE ctsi_webcamp_adhoc.OPV AS
SELECT op.UNIQUEFIELD AS OPVisitID,
       op.STATUS AS VisitStatus,
       CONCAT(Year(op.VISITDATE),"-",LPAD(MONTH(op.VISITDATE),2,"0")) AS VisitMonth,
       op.VISITDATE,
       op.PROTOCOL As ProtoID
from ctsi_webcamp_pr.opvisit op
WHERE op.VISITDATE>=str_to_date('07,01,2019','%m,%d,%Y')
AND op.STATUS in (1,2,3,8)
GROUP BY 	op.UNIQUEFIELD,
            op.STATUS ,
            CONCAT(Year(VISITDATE),"-",LPAD(MONTH(VISITDATE),2,"0")),
			op.PROTOCOL;

######### ADD CORESERVICE Fields


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.OPVCS;
CREATE TABLE ctsi_webcamp_adhoc.OPVCS AS
SELECT op.OPVisitID,
       op.VisitMonth,
       op.VISITDATE,
       op.VisitStatus,
       op.ProtoID,
       cs.UNIQUEFIELD AS CoreSvcID,
       cs.LABTEST AS LABTEST,
       cs.QUANTITY_OF_SERVICE as SvcQuant,
       cs.Status AS CoreSvcStatus
from ctsi_webcamp_adhoc.OPV op
	LEFT JOIN ctsi_webcamp_pr.coreservice cs
    ON op.OPVisitID=cs.OPVISIT 
;

## 2 rategorups in rategroup table
## ADD RATEGROUP_DEFAULT bigint(20),  ## ALL NULL
## ADD RATESPEC_DEFAULT float,  ## ALL NULL

ALTER TABLE ctsi_webcamp_adhoc.OPVCS 
ADD INDUSTRYSUPPORTINIT tinyint(4),
ADD RATETYPE_DEFAULT tinyint(4),
ADD ServiceDesc varchar(100),
ADD Amount float ,
ADD TotAmt float,
ADD CRCNum varchar(25),
ADD ProtoTitle varchar(90),
ADD PI_Person bigint(20),
ADD PI_LastName varchar(30),
ADD ProtoSpecRate int(1);
;


SET SQL_SAFE_UPDATES = 0;

######### ADD PROTOCOL SPECIFIC COST MODIFIERS

	###op.RATEGROUP_DEFAULT=lu.RATEGROUP_DEFAULT,  ## ALL ARE NULL
	###op.RATESPEC_DEFAULT=lu.RATESPEC_DEFAULT,    ## ALL ARE NULL

UPDATE 	ctsi_webcamp_adhoc.OPVCS op, 
		ctsi_webcamp_pr.protocol lu
SET op.INDUSTRYSUPPORTINIT=lu.INDUSTRYSUPPORTINIT,
    op.RATETYPE_DEFAULT=lu.RATETYPE_DEFAULT
WHERE op.ProtoID=lu.UNIQUEFIELD;
	
######### ADD SERVICE DESCRIPTION	
UPDATE 	ctsi_webcamp_adhoc.OPVCS op,
		ctsi_webcamp_pr.labtest lu
SET op.ServiceDesc=lu.LABTEST
WHERE op.LABTEST=lu.UNIQUEFIELD;


######### ADD CRC Number
UPDATE 	ctsi_webcamp_adhoc.OPVCS op,
		ctsi_webcamp_pr.protocol lu
SET op.CRCNum=lu.PROTOCOL,
    op. ProtoTitle=lu.TITLE,
    op.PI_Person=lu.PERSON
WHERE op.ProtoID=lu.UNIQUEFIELD;


######### ADD PI INFO
UPDATE 	ctsi_webcamp_adhoc.OPVCS op,
		ctsi_webcamp_pr.person lu
SET op.PI_LastName=lu.LASTNAME
WHERE op.PI_Person=lu.UNIQUEFIELD;
#

######### ADD NON-PROTOCL SPECIFIC COST DATA 
UPDATE 	ctsi_webcamp_adhoc.OPVCS op, 
		ctsi_webcamp_pr.labtestcost lu
SET op.Amount=lu.DEFAULTCOST
WHERE op.LABTEST=lu.LABTEST
  AND (op.VISITDATE>=lu.STARTDATE or lu.STARTDATE IS NULL)
  AND (op.VISITDATE<=lu.ENDDATE OR lu.ENDDATE IS NULL);

######### UPDATE PROTOCOL SPECIFIC Service Costs
UPDATE 	ctsi_webcamp_adhoc.OPVCS op
SET ProtoSpecRate=0;

UPDATE 	ctsi_webcamp_adhoc.OPVCS op,
		ctsi_webcamp_pr.approvedresource ar
SET op.AMOUNT=ar.RATESPEC,
    op.ProtoSpecRate=1
WHERE op.ProtoID=ar.PROTOCOL
  AND op.LABTEST=ar.LABTEST;
  #AND op.AMOUNT IS NULL;   

######### PRICE ZERO COST SERVICES NOT FOUND IN LABTEST COST
UPDATE ctsi_webcamp_adhoc.OPVCS
       SET Amount=0
WHERE LABTEST IN (154, 220, 143);
 
######### UPDATE ALL TOTAL AMOUNT
UPDATE ctsi_webcamp_adhoc.OPVCS op
SET op.TotAmt=op.AMOUNT*op.SvcQuant;

###########################################################################################################
###########################################################################################################
#### Create Summary Table for reporting


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.OPSumm;
CREATE TABLE ctsi_webcamp_adhoc.OPSumm AS
SELECT 	VisitMonth, 
		Count(distinct OPVisitID) AS nVisits,
        Count(LABTEST) AS nSVCs,
        ##SUM(SvcQuant) as nSVCUnits,
        Sum(TotAmt) AS TotalAmt
FROM ctsi_webcamp_adhoc.OPVCS
WHERE (VISITDATE>=curdate()AND VisitStatus=1) OR (VISITDATE<=curdate() and VisitStatus=2)
GROUP BY VisitMonth
ORDER BY VisitMonth;        

#################  EOF ####################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################

### DIAGNOSTICS


## SERVCICES WITH NO PRICE

select ProtoID,CrcNum,ProtoTitle,LABTEST, ServiceDesc, VisitStatus, min(VisitDate), Max(VisitDate),count(*) from ctsi_webcamp_adhoc.OPVCS
WHERE AMOUNT iS NULL
GROUP BY ProtoID,CrcNum, ProtoTitle,LABTEST, ServiceDesc, VisitStatus;


drop table if exists ctsi_webcamp_adhoc.noAmtdtl ;
create table ctsi_webcamp_adhoc.noAmtdtl
select ProtoID,CrcNum,VisitDate,VisitStatus,ProtoTitle,PI_LastName, LABTEST, ServiceDesc 
from ctsi_webcamp_adhoc.OPVCS
WHERE  AMOUNT IS NULL
ORDER BY PI_LastName,CrcNum,VisitDate;
;

SELECT count(*) from ctsi_webcamp_adhoc.OPVCS;
SELECT count(*) from ctsi_webcamp_adhoc.OPVCS WHERE  AMOUNT IS NULL;