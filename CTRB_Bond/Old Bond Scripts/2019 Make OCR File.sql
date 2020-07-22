DROP TABLE IF EXISTS space.IP_Determine_2019;
CREATE TABLE space.IP_Determine_2019 AS

SELECT 	Space(20) AS DSP_Determine,
		AWARD_ID_Number AS Award,
		concat(LastName,", ",FirstName) AS PI_NAME,
		AWARD_INV_UFID AS PI_UFID,
		SponsorName,
		SponsorID,
		Title,
		Total_Award,
		bondmaster_key,
		Award_ID,
		Span
from space.bondmaster
WHERE IP_USAGE IS NULL
OR SponsorName="PATIENT-CENTERED OUTCOMES RES INST"
order by LastName,FirstName;


select count(*) from space.bondmaster;
select count(*) from space.bondmaster where CTRB_PCT_PREV is NOT NULL;