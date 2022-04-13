select count(*) from lookup.email_master
WHERE UF_ACTIVE_FLG="Y";

select distinct UF_PRIMARY_FLG from lookup.email_master;

CREATE INDEX emaillookup ON lookup.email_master (UF_EMAIL);

SELECT 	STD_PROGRAM,
		ORIG_PROGRAM,
        COUNT(*) as NumRecs,
        COUNT(DISTINCT Person_key) as Undup
        from lookup.roster WHERE Year=2021
        Group by STD_PROGRAM, ORIG_PROGRAM
        ORDER BY STD_PROGRAM, ORIG_PROGRAM;