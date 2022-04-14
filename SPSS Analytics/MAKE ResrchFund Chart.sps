

GET   FILE='P:\My Documents\My Documents\GrantsData\SR_MASTER ALL  EN.sav'.


Compute DropCase=0.
If Category="Instruction/Non Research Training" DropCase=1.
If Category="Other" DropCase=1.
If Category="Research Training" AND Fiscal_Year <> 2012 DropCase=1.
Execute.

Select if DropCase=0.
Execute.

String ARRA (A8).
Compute ARRA="Non-ARRA".
IF Special_Program="ARRA" ARRA="ARRA".
IF TITLE="THE LIFE STUDY" ARRA="ARRA".
IF TITLE="THE LIFE STUDY (SUPPLEMENT)"  ARRA="ARRA".
IF TITLE="THE LIFE STUDY DIVERSITY SUPPLEMENT FOR VONETTA DOTSON" ARRA="ARRA".
EXECUTE.



SAVE OUTFILE='P:\My Documents\My Documents\GrantsData\SR_MASTER CHART.sav'
  /COMPRESSED.

SUMMARIZE
  /TABLES=Total_Awarded BY Fiscal_Year
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=SUM.




USE ALL.
COMPUTE filter_$=(Fiscal_Year>=2008 & Fiscal_Year<=2013).
FILTER BY filter_$.
EXECUTE.

String CTSI_YEAR (A8).
Compute CTSI_YEAR="Not-CTSI".
IF Fiscal_Year=2008 AND CTSI_2009=1 CTSI_YEAR="CTSI".
IF Fiscal_Year=2009 AND CTSI_2009=1 CTSI_YEAR="CTSI".
IF Fiscal_Year=2010 AND CTSI_2010=1 CTSI_YEAR="CTSI".
IF Fiscal_Year=2011 AND CTSI_2011=1 CTSI_YEAR="CTSI".
IF Fiscal_Year=2012 AND CTSI_2012=1 CTSI_YEAR="CTSI".
IF Fiscal_Year=2013 AND CTSI_2013=1 CTSI_YEAR="CTSI".
EXECUTE.




AGGREGATE
  /OUTFILE='P:\My Documents\My Documents\GrantsData\ResrchFundChart.sav'
  /BREAK=Fiscal_Year ARRA HSC CTSI_YEAR
  /Total_Awarded=SUM(Total_Awarded).



GET FILE='P:\My Documents\My Documents\GrantsData\ResrchFundChart.sav'.


SUMMARIZE
  /TABLES=Total_Awarded BY HSC BY Fiscal_Year BY ARRA BY CTSI_YEAR
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=SUM.



SUMMARIZE
  /TABLES=Total_Awarded BY HSC BY Fiscal_Year BY CTSI_YEAR
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=SUM.










GET
  FILE='P:\My Documents\My Documents\GrantsData\SR_MASTER ALL  EN.sav'.

