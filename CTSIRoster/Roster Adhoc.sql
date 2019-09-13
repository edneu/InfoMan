  select distinct STD_PROGRAM FROM lookup.roster WHERE Year in (2018,2019) ORDER BY STD_PROGRAM;

  select distinct ORIG_PROGRAM,STD_PROGRAM FROM lookup.roster WHERE Year in (2018,2019) ORDER BY STD_PROGRAM ;
  
  select distinct STD_PROGRAM FROM lookup.roster;
  
  select year, count(*) from lookup.roster where STD_PROGRAM='One Florida' group by Year;