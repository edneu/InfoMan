

select * from work.woodsvivo;

select * from work.woodscv;


select count(*) from work.woodsvivo;
## 89

select count(distinct VIVO_CITE) from work.woodsvivo;
## 82


## REMOVE DUPS FROM vivo
DROP TABLE IF EXISTS work.vivonodup;
create table work.vivonodup as
SELECT VIVO_CITE,Min(Vivo_seq) as vivoseq
FROM work.woodsvivo
GROUP BY VIVO_CITE;


ALTER TABLE work.woodscv add vivoseq int(10),
				add vivo_cite varchar(4000);


SET SQL_SAFE_UPDATES = 0;
    
    
UPDATE work.woodscv cv SET  cv.vivoseq=NULL;    

UPDATE work.woodscv cv, work.vivonodup lu
SET cv.vivoseq=lu.vivoseq
WHERE LOCATE(substr(lu.VIVO_CITE,1,35),CV_CITATION)<>0;


UPDATE work.woodscv cv, work.vivonodup lu
SET cv.vivo_cite=lu.VIVO_CITE
WHERE cv.vivoseq=lu.vivoseq;

select * from work.woodscv;


