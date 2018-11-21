



SET SQL_SAFE_UPDATES = 0;


/*
select Year,count(*) from lookup.blueridge_medicine Group by Year order by Year;
select Year,count(*) from lookup.blueridge_institution Group by Year order by Year;
*/


ALTER TABLE lookup.blueridge_institution ADD PublicInst integer(1);
ALTER TABLE lookup.blueridge_institution ADD PublicRank integer(6);
ALTER TABLE lookup.blueridge_medicine ADD PublicInst integer(1);
ALTER TABLE lookup.blueridge_medicine ADD PublicRank integer(6);


UPDATE lookup.blueridge_institution SET PublicInst=0;
UPDATE lookup.blueridge_medicine SET PublicInst=0;

UPDATE lookup.blueridge_institution br
SET PublicInst=1
WHERE br.Name IN (Select distinct Name from lookup.public_institutions where PublicInst=1) ;


UPDATE lookup.blueridge_medicine br
SET PublicInst=1
WHERE br.Name IN (Select distinct Name from lookup.public_institutions where PublicInst=1) ;


drop table if exists work.bri_public;
create table work.bri_public AS
SELECT * from lookup.blueridge_institution WHERE PublicInst=1
ORDER BY Year,Rank;

drop table work.brm_public;
create table work.brm_public AS
SELECT * from lookup.blueridge_medicine WHERE PublicInst=1
ORDER BY Year,Rank;



###########################################################
######CREATE RANKINGS FOR PUBLIC INSTITUTIONS ONLY ########
##################  SELF JOIN #############################

drop table if exists work.br_Inst_publicrank;
create table work.br_Inst_publicrank AS
Select a.blueridge_institution_id2,
       a.Name,
       a.NIH_FUNDING,
       a.Year,
       a.Rank,
       count(b.Rank)+1 As PubRank
FROM work.bri_public a left join work.bri_public b on a.Year=b.Year AND a.Rank>b.Rank
GROUP BY Year,
         Rank;





drop table if exists work.br_med_publicrank;
create table work.br_med_publicrank AS
Select a.blueridge_medicine_id2,
       a.Name,
       a.Award,
       a.Year,
       a.Rank,
       count(b.Rank)+1 As PubRank
FROM work.brm_public a left join work.brm_public b on a.Year=b.Year AND a.Rank>b.Rank
GROUP BY Year,
         Rank;


UPDATE lookup.blueridge_institution br, work.br_Inst_publicrank lu
    SET br.PublicRank=lu.PubRank
    WHERE br.blueridge_institution_id2=lu.blueridge_institution_id2;  



UPDATE lookup.blueridge_medicine br, work.br_med_publicrank lu
     SET br.PublicRank=lu.PubRank
     WHERE br.blueridge_medicine_id2=lu.blueridge_medicine_id2;   


SELECT Year,Name,NIH_FUNDING,Rank,PublicRank
FROM lookup.blueridge_institution
WHERE Name="University of Florida"
ORDER BY YEAR;

SELECT Year,Name,Award,Rank,PublicRank
FROM lookup.blueridge_medicine
WHERE Name="University of Florida"
ORDER BY YEAR;

drop table if exists work.top65inst;
create table work.top65inst AS
select * from lookup.blueridge_institution
Where Rank<=65
Order by Year,Rank;

drop table if exists work.top65med;
create table work.top65med AS
select * from lookup.blueridge_medicine
Where Rank<=65
Order by Year,Rank;
