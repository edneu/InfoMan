#####################################################################################################################
#####################################################################################################################
#####################################################################################################################
############# QUARTERLY REPORTING
#####################################################################################################################
#####################################################################################################################
### VERIFY DATES from Analysis Files ###
select "timerept" as Filename, count(*) as nRecs, min(Date_Used) as MinDate, max(Date_Used) as MaxDate from timerept
UNION ALL
select "shandstime" as Filename, count(*) as nRecs, min(Shift_Start_Time_) as MinDate, max(Shift_Start_Time_) as MaxDate from shandstime
UNION ALL
select "cost_dist" as Filename, count(*) as nRecs, min(Accounting_Date) as MinDate, max(Accounting_Date) as MaxDate from cost_dist
UNION ALL
select "visitroomcore" as Filename, count(*) as nRecs, min(VisitStart) as MinDate, max(VisitStart) as MaxDate from visitroomcore
UNION ALL
select "EmpTimeSal" as Filename, count(*) as nRecs, min(Month) as MinDate, max(Month) as MaxDate from EmpTimeSal;
#####################################################################################################################
#####################################################################################################################

## Quarterly Utilization By Room ##

