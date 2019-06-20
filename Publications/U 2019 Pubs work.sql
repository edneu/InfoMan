#### PARSE PUBMED SUMMARY OUTPUT
##DROP table work.pubmed_raw;
##
create table work.pubmed_raw 
select * from pubs.pubmed_u;

############################################
##########  ADD COLUMNS TO RAW PUBMED OUTPUT
#############################################


Alter table work.pubmed_raw
ADD Citation varchar(4000),
ADD PMID varchar(12),
ADD PMCID varchar(12);

SET SQL_SAFE_UPDATES = 0;

## REMOVE LEADING NUMBER FROM PUBMED OUTPUT
UPDATE work.pubmed_raw
SET Citation=SUBSTR(Raw, LOCATE(":",RAW)+2, CHAR_LENGTH(Raw)-(LOCATE(":",RAW)+2));

## EXTRACT PMID
UPDATE work.pubmed_raw
SET PMID=SUBSTR(Raw, LOCATE("PMID:",RAW)+6, 8)
WHERE substr(raw,LOCATE("PMID:",RAW)+6,1)<>" ";

## To handle cases with 2 spaces after PMID:
UPDATE work.pubmed_raw
SET PMID=SUBSTR(Raw, LOCATE("PMID:",RAW)+7, 8)
WHERE substr(raw,LOCATE("PMID:",RAW)+6,1)=" ";



## EXTRACT PMCID
UPDATE work.pubmed_raw
SET PMCID=SUBSTR(Raw, LOCATE("PMCID:",RAW)+7, 10)
WHERE LOCATE("PMCID:",RAW)>0;

SET SQL_SAFE_UPDATES = 1;


##### MAKE Pubmed Output file
DROP TABLE IF EXISTS work.PubmedOUT;
create table work.PubmedOUT as
select PMID,PMCID,Citation from 
work.pubmed_raw
order by PMID;

select * from work.PubmedOUT;
/*
create table pubs.pubmed_allu AS
select * from work.PubmedOUT;
*/
##############################


desc pubs.PUB_CORE;

select distinct PMC from pubs.PUB_CORE;
UPDATE pubs.pubmed_allu SET PMCID="" WHERE PMCID IS NULL; 
*/

SELECT pubmaster_id2,PMID
FROM pubs.PUB_CORE
WHERE May18Grant=1
AND PMC="" ;

####################################################################################
####################################################################################
####################################################################################
####################################################################################
####################################################################################
####################################################################################

DROP TABLE IF EXISTS pubs.AllPubs;
CREATE TABLE pubs.AllPubs As
SELECT "GrantApp" As `Grant`,
        PMID,
        PMC AS PMCID,
        CITATION
FROM pubs.PUB_CORE
WHERE May18Grant=1
UNION ALL
SELECT 	`Grant`,
		PMID,
        PMCID,
        Citation
from pubs.pubmed_allu
WHERE PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
UNION ALL
SELECT 	"Oct18Prog" AS `Grant`,
		PMID,
        PMC AS PMCID,
        Citation
from pubs.PUB_CORE
WHERE PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu)
  AND ProgOct2018=1
  AND PMID<>""
  AND PMC<>"";

;



select distinct PMCID from pubs.pubmed_allu;

DELETE FROM pubs.AllPubs WHERE PMID="" OR PMID IS NULL;



SELECT "Submitted on Grant with PMID" AS Measure, Count(distinct PMID) AS NumUnDupPubs from pubs.AllPubs WHERE `Grant`="GrantApp"
UNION ALL
SELECT "Submitted on Grant with PMID AND PMCID" AS Measure, Count(distinct PMID) AS NumUnDupPubs from pubs.AllPubs WHERE `Grant`="GrantApp" AND PMCID <>""
UNION ALL
SELECT "New Pubs Submitted 2018 Progress Reports with PMCID" AS Measure, Count(distinct PMID) AS NumUnDupPubs from pubs.AllPubs WHERE `Grant`="Oct18Prog" AND PMCID<>"" 
UNION ALL
SELECT "Additional New PMC Pubs Citing TR001427" AS Measure, Count(distinct PMID) AS NumUnDupPubs 
		from pubs.AllPubs 
		WHERE `Grant`="TR001427"
        AND PMCID<>""
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE ProgOct2018=1)
UNION ALL
SELECT "Additional New PMC Pubs Citing TR000064" AS Measure, Count(distinct PMID) AS NumUnDupPubs 
		from pubs.AllPubs 
		WHERE `Grant`="TR000064"
         AND PMCID<>""
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE ProgOct2018=1)
          AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu WHERE `Grant` IN ("TR001427"))
UNION ALL 
SELECT "Additional New PMC Pubs Citing RR029890" AS Measure, Count(distinct PMID) AS NumUnDupPubs 
		from pubs.AllPubs 
		WHERE `Grant`="RR029890"
         AND PMCID<>""
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE ProgOct2018=1)
          AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu WHERE `Grant` IN ("TR001427","TR000064"));


ALTER TABLE pubs.AllPubs ADD KeepFlag int(1);


UPDATE pubs.AllPubs SET KeepFlag=0; 

## Submiited on Grant and PMC 
UPDATE pubs.AllPubs SET KeepFlag=1 WHERE `Grant`="GrantApp" AND PMCID <>"";
## Submitted on Progress Reports and PMC
UPDATE pubs.AllPubs SET KeepFlag=1 WHERE  `Grant`="Oct18Prog" AND PMCID<>"" ;
## New PMC Pubs Citing TR001427
UPDATE pubs.AllPubs SET KeepFlag=1 
	WHERE `Grant`="TR001427"
          AND PMCID<>""
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE ProgOct2018=1);
   
          
          
          
ALTER TABLE pubs.AllPubs ADD PMCite01427 int(1),
						 ADD PMCite00064 int(1),
						 ADD PMCite29860 int(1), 
                         ADD ProgRept    int(1),
                         ADD GrantApp    int(1);
 

 
UPDATE pubs.AllPubs SET PMCite01427 = 0, PMCite00064 = 0, PMCite29860=0, ProgRept=0, GrantApp=0;

UPDATE pubs.AllPubs SET PMCite01427 = 1 
WHERE PMID IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu WHERE `Grant`="TR001427");
 
UPDATE pubs.AllPubs SET PMCite00064 = 1 
WHERE PMID IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu WHERE `Grant`="TR000064"); 
          
UPDATE pubs.AllPubs SET PMCite29860 = 1 
WHERE PMID IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu WHERE  `Grant`="RR029890");     

UPDATE pubs.AllPubs SET ProgRept = 1 
WHERE `Grant`="Oct18Prog" ;  
      
UPDATE pubs.AllPubs SET GrantApp = 1 
WHERE PMID IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1) ;        
          
##  CITE CURENT GRANT AND PMC (Dups with citing 0064)
UPDATE pubs.AllPubs SET KeepFlag=1 WHERE  PMCite01427 = 1  AND PMCID<>"" ;

#############################################
#############################################




      
		
SELECT * from pubs.AllPubs WHERE KeepFlag=0 and PMCite01427 = 1 ;   

SELECT * from pubs.AllPubs WHERE KeepFlag=1 and PMCID="";          
SELECT * from pubs.AllPubs WHERE KeepFlag=1 and PMCID="";            
          
SELECT DISTINCT PMID FROM pubs.AllPubs WHERE KeepFlag=1    ;   


SELECT PMID,PMCID,CITATION  FROM pubs.AllPubs WHERE KeepFlag=1    ;  




SELECT "Submitted on Grant with PMID" AS Measure, Count(distinct PMID) AS NumUnDupPubs from pubs.AllPubs WHERE `Grant`="GrantApp"
UNION ALL
SELECT "Submitted on Grant with PMID AND PMCID" AS Measure, Count(distinct PMID) AS NumUnDupPubs from pubs.AllPubs WHERE `Grant`="GrantApp" AND PMCID <>"" AND KeepFlag=1
UNION ALL
SELECT "New Pubs Submitted 2018 Progress Reports with PMCID" AS Measure, Count(distinct PMID) AS NumUnDupPubs from pubs.AllPubs WHERE `Grant`="Oct18Prog" AND PMCID<>"" AND KeepFlag=1
UNION ALL
SELECT "Additional New PMC Pubs Citing TR001427" AS Measure, Count(distinct PMID) AS NumUnDupPubs 
		from pubs.AllPubs 
		WHERE `Grant`="TR001427"
        AND PMCID<>""
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE ProgOct2018=1)
          AND KeepFlag=1
UNION ALL
SELECT "Additional New PMC Pubs Citing TR000064" AS Measure, Count(distinct PMID) AS NumUnDupPubs 
		from pubs.AllPubs 
		WHERE `Grant`="TR000064"
         AND PMCID<>""
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE ProgOct2018=1)
          AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu WHERE `Grant` IN ("TR001427"))
          AND KeepFlag=1
UNION ALL 
SELECT "Additional New PMC Pubs Citing RR029890" AS Measure, Count(distinct PMID) AS NumUnDupPubs 
		from pubs.AllPubs 
		WHERE `Grant`="RR029890"
         AND PMCID<>""
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE May18Grant=1)
		  AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE WHERE ProgOct2018=1)
          AND PMID NOT IN (SELECT DISTINCT PMID FROM pubs.pubmed_allu WHERE `Grant` IN ("TR001427","TR000064"))
          AND KeepFlag=1;
          
          
DROP TABLE IF EXISTS pubs.JIT4U;
CREATE TABLE pubs.JIT4U AS
SELECT PMID,
       max(PMCID) As PMCID,
       max(CITATION) as CITATION,
       max(KeepFlag) as KeepFlag,
       max(PMCite01427) as PMCite01427,
       max(PMCite00064) as PMCite00064,
       max(PMCite29860) as PMCite29860,
       max(ProgRept) as ProgRept,
       max(GrantApp) as GrantApp
FROM pubs.AllPubs
WHERE  KeepFlag=1
GROUP BY PMID
ORDER BY PMID;
       
 drop table if exists pubs.temp;      
 create table pubs.temp as
 SELECT KeepFlag,PMCite01427,PMCite00064,PMCite29860,ProgRept,GrantApp,
 Count(distinct PMID)
 FROM pubs.AllPubs
 GROUP BY KeepFlag,PMCite01427,PMCite00064,PMCite29860,ProgRept,GrantApp;
 
 select * from pubs.AllPubs WHERE KeepFlag=1
 AND PMCite01427+PMCite00064+PMCite29860+ProgRept=0;
 
 
 
 ########## VERIFY FOR CLAIRE
 drop table if exists pubs.temp;
create table pubs.temp as
 SELECT pubmaster_id2,
		PMID,
        PMC,
        May18Grant,
        PilotPub,
        Pilot_ID,
        ProgReptSrce,
        ProgOct2018,
        PubDate,
        Citation
  From pubs.PUB_CORE
  WHERE PMID IN
('28197299',
'28970488',
'30295548',
'29160173',
'29701153',
'30076274')
AND pubmaster_id2<>613;

######################################################################################################################
######################################################################################################################
desc pubs.PUB_CORE;

select * from  pubs.PUB_CORE WHERE Citation like "%Fishe%";