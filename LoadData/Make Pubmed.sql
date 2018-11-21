########################################################################
########################################################################
########################################################################
########################################################################



drop table if exists loaddata.pubmedwork;
create table loaddata.pubmedwork AS
select * from loaddata.pubmed2008_17;



drop table if exists loaddata.ctsipubs;
create table loaddata.ctsipubs AS
select * 
from loaddata.pubmedwork
#where Grant_Number IN (select distinct Grant_Num from lookup.ctsi_grants);
;


drop table if exists loaddata.grantscited;
create table loaddata.grantscited AS
select  PMID,
        GROUP_CONCAT(DISTINCT Grant_Number SEPARATOR ', ') As CitedGrants
from loaddata.ctsipubs
group by PMID
;



drop table if exists loaddata.pubmed_noncomp_ctsi;
create table loaddata.pubmed_noncomp_ctsi AS
SELECT PMID,
Max(Publication_Date) as Publication_Date,
MAX(Article_Title) as Article_Title,
MAX(First_Author_Name) As AuthorName,
MAX(Journal_Title) As Journal_Title,
max(Journal_Publisher) as Journal_Publisher
from loaddata.ctsipubs 
GROUP BY PMID;



ALTER TABLE loaddata.pubmed_noncomp_ctsi ADD CitedGrants text,
                                         ADD LastName varchar(45),
                                         ADD FirstName varchar(45)  ;         

SET SQL_SAFE_UPDATES = 0;

UPDATE loaddata.pubmed_noncomp_ctsi pm, loaddata.grantscited gc
SET pm.CitedGrants=gc.CitedGrants
WHERE pm.PMID=gc.PMID;


UPDATE loaddata.pubmed_noncomp_ctsi
SET LastName=concat(UPPER(substr(AuthorName,1,1) ) ,
                     lower(substr(AuthorName,2,Locate(",",AuthorName)-2))),
    FirstName=concat(UPPER(substr(AuthorName,Locate(",",AuthorName)+2,1)),
              lower(substr(AuthorName,Locate(",",AuthorName)+3,length(AuthorName)-Locate(",",AuthorName)-2)));


drop table if exists loaddata.pubmed_qualtrics;
Create Table loaddata.pubmed_qualtrics AS
SELECT space(45) as Email,
LastName,
FirstName,
PMID,
Publication_Date,
Article_Title,
Journal_Title,
Journal_Publisher,
CitedGrants,
space(4000) as Citation
FROM loaddata.pubmed_noncomp_ctsi;

                                   


Drop table if exists brian.pubmed_qualtrics;
Create table brian.pubmed_qualtrics
select * from loaddata.pubmed_qualtrics;

select * from brian.pubmed_qualtrics;




drop table if exists loaddata.pubmedwork;
drop table if exists loaddata.grantscited;
drop table if exists loaddata.ctsipubs;
##drop table if exists loaddata.pubmed_noncomp_ctsi;
########################################################################
## PUBMED LOG
##  WILL NEED TO INSERT NEW DATA After APRIL 2017
select * from lookup.PubMedLog;

drop table if exists  work.pmlog ;
create table work.pmlog As
select * from lookup.PubMedLog;

INSERT INTO work.pmlog
()





########################################################################
########################################################################
########################################################################
;

create table brian.pubmedemaillookup AS
SELECT	UF_EMAIL,
		UF_UFID,
		UF_LAST_NM,
		UF_FIRST_NM,
		UF_MIDDLE_NM,
		UF_WORK_TITLE,
		UF_DEPT_NM,
		UF_BIRTH_DT
FROM lookup.ufids
WHERE 
(UF_LAST_NM='Acosta' AND UF_FIRST_NM='Andres' ) OR
(UF_LAST_NM='Alvarez' AND UF_FIRST_NM='Rebeca' ) OR
(UF_LAST_NM='Cannon' AND UF_FIRST_NM='S' ) OR
(UF_LAST_NM='Conrado' AND UF_FIRST_NM='Daniela' ) OR
(UF_LAST_NM='Crary' AND UF_FIRST_NM='Michael' ) OR
(UF_LAST_NM='Gupta' AND UF_FIRST_NM='Ashish' ) OR
(UF_LAST_NM='Hausenblas' AND UF_FIRST_NM='Heather' ) OR
(UF_LAST_NM='Hinojosa' AND UF_FIRST_NM='Melanie' ) OR
(UF_LAST_NM='Jiang' AND UF_FIRST_NM='Xi ling' ) OR
(UF_LAST_NM='Kadivar' AND UF_FIRST_NM='Hajar' ) OR
(UF_LAST_NM='Khaybullin' AND UF_FIRST_NM='Ravil' ) OR
(UF_LAST_NM='Kwon' AND UF_FIRST_NM='Hyung' ) OR
(UF_LAST_NM='Lawitz' AND UF_FIRST_NM='Eric' ) OR
(UF_LAST_NM='Lu' AND UF_FIRST_NM='Jia' ) OR
(UF_LAST_NM='Mehta' AND UF_FIRST_NM='Hiren' ) OR
(UF_LAST_NM='Peng' AND UF_FIRST_NM='Lucinda' ) OR
(UF_LAST_NM='Rodriguez-torres' AND UF_FIRST_NM='Maribel' ) OR
(UF_LAST_NM='Sattari' AND UF_FIRST_NM='Maryam' ) OR
(UF_LAST_NM='Schaefer' AND UF_FIRST_NM='Jamie' ) OR
(UF_LAST_NM='Shuster' AND UF_FIRST_NM='Jonathan' ) OR
(UF_LAST_NM='Tsai' AND UF_FIRST_NM='Yu hsuan' ) OR
(UF_LAST_NM='Vincent' AND UF_FIRST_NM='Heather' ) OR
(UF_LAST_NM='Wagle shukla' AND UF_FIRST_NM='Aparna' ) OR
(UF_LAST_NM='Waters' AND UF_FIRST_NM='Michael' ) OR
(UF_LAST_NM='Wells' AND UF_FIRST_NM='Saran' );



select * from lookup.ufids where UF_LAST_NM="Tran" AND UF_FIRST_NM="CUC";
