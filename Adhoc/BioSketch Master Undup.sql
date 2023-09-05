select * from lookup.ufids
WHERE UF_DISPLAY_NM LIKE "liu%mei%";

desc work.biomaster;


DROP TABLE IF EXISTS work.bio_undup_roles;
CREATE TABLE work.bio_undup_roles AS
SELECT 
     min(OrigSeq) as Seq,
     max(`Biosketch_Needed?_DM`) AS Biosketch_Needed_DM,
     GROUP_CONCAT(CTSI_Role) AS CTSI_Roles,
     GROUP_CONCAT(RFA_Element) AS RFA_Elements,
     max(UFID) AS UFID,
     max(FirstName) AS FirstName,
     max(LastName) AS LastName,    
     max(eRA_Username) AS eRA_Username,
     max(Email) AS Email,
     Name
FROM work.biomaster    
GROUP BY NAME
ORDER BY SEQ; 

### Drop Table if Exists work.biomaster ;