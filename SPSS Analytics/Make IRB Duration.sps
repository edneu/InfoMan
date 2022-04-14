* Encoding: UTF-8.

* Load Data from IRB Spreadsheet



*** GET EXCEL FILE FROM IRB

*** Date_Originally_Approved  !!!!!!!!!!!!!!!!!!


COMPUTE IRB_APPROVAL_TIME=(Date_Originally_Approved-Date_IRB_Received)/(60*60*24).
EXECUTE.


COMPUTE IRB_APPROVAL_YEAR=XDATE.YEAR(Date_Originally_Approved).
COMPUTE IRB_APPROVAL_MON=XDATE.MONTH(Date_Originally_Approved).
EXECUTE.

STRING IRB_APP_MON2 (A2).
IF IRB_APPROVAL_MON<=9 IRB_APP_MON2=CONCAT("0",STRING(IRB_APPROVAL_MON,F1)).
IF IRB_APPROVAL_MON>=10 IRB_APP_MON2=STRING(IRB_APPROVAL_MON,F2).
EXECUTE.


STRING IRB_Approval_Month (A12).
COMPUTE IRB_Approval_Month=CONCAT(STRING(IRB_APPROVAL_YEAR,F4),"-" , IRB_APP_MON2 ).
EXECUTE.


STRING Quarter (A2).
IF IRB_APPROVAL_MON>=1 AND IRB_APPROVAL_MON<=3 Quarter="Q1".
IF IRB_APPROVAL_MON>=4 AND IRB_APPROVAL_MON<=6 Quarter="Q2".
IF IRB_APPROVAL_MON>=7 AND IRB_APPROVAL_MON<=9 Quarter="Q3".
IF IRB_APPROVAL_MON>=10 AND IRB_APPROVAL_MON<=12 Quarter="Q4".
EXECUTE.


STRING IRB_Approval_Quarter (A12).
COMPUTE IRB_Approval_Quarter=CONCAT(STRING(IRB_APPROVAL_YEAR,F4),"-" , Quarter ).
EXECUTE.

Compute ZeroApporvalTime=0.
IF IRB_APPROVAL_TIME=0  ZeroApporvalTime=1.
EXECUTE.


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\Common Metrics\DataSources\IRB Duration.sav'
  /DROP=IRB_APPROVAL_MON IRB_APP_MON2 Quarter
  /COMPRESSED.

GET FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\Common Metrics\DataSources\IRB Duration.sav'.

FILTER OFF.
USE ALL.
SELECT IF (Committee="IRB-01").
EXECUTE.

SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\Common Metrics\DataSources\IRB-01 Duration.sav'
  /COMPRESSED.

GET FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\Common Metrics\DataSources\IRB-01 Duration.sav'.

SUMMARIZE
  /TABLES=IRB_APPROVAL_TIME BY IRB_Approval_Month BY Review_Type
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=MEAN MEDIAN RANGE.


SUMMARIZE
  /TABLES=IRB_APPROVAL_TIME BY  IRB_APPROVAL_YEAR BY Review_Type
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=MEDIAN.






SUMMARIZE
  /TABLES=IRB_APPROVAL_TIME BY IRB_Approval_Month BY Review_Type
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=MEAN MEDIAN RANGE STDDEV.





USE ALL.

SELECT IF  IRB_Approval_Month="2015-07" |
 IRB_Approval_Month="2015-08" |
 IRB_Approval_Month="2015-09" |
 IRB_Approval_Month="2015-10" |
 IRB_Approval_Month="2015-11" |
 IRB_Approval_Month="2015-12" |
 IRB_Approval_Month="2016-01" |
 IRB_Approval_Month="2016-02" |
 IRB_Approval_Month="2016-03" |
 IRB_Approval_Month="2016-04" |
 IRB_Approval_Month="2016-05" |
 IRB_Approval_Month="2016-06" |
 IRB_Approval_Month="2016-07".

SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\Common Metrics\DataSources\IRB-01 2016 Duration.sav'
  /COMPRESSED.

GET FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\Common Metrics\DataSources\IRB-01 2016 Duration.sav'.


SUMMARIZE
  /TABLES=IRB_APPROVAL_TIME BY IRB_Approval_YEAR BY Review_Type
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=MEDIAN.

***** ADHOC

DATASET ACTIVATE $DataSet.
USE ALL.
COMPUTE filter_$=(Current_Status<>"Closed" | Current_Status<>"Suspended").
VARIABLE LABELS filter_$ 'Current_Status<>"Closed" AND Current_Status<>"Suspended" (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


SUMMARIZE
  /TABLES=IRB_APPROVAL_TIME BY Review_Type BY Current_Status
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=MEAN MEDIAN MIN MAX COUNT NPCT.

GRAPH
  /LINE(MULTIPLE)=MED(IRB_APPROVAL_TIME) BY IRB_Approval_Month BY Review_Type.

GRAPH
  /LINE(MULTIPLE)=MED(IRB_APPROVAL_TIME) BY IRB_Approval_Quarter BY Review_Type.

GRAPH
  /LINE(MULTIPLE)=MED(IRB_APPROVAL_TIME) BY IRB_Approval_Quarter.


USE ALL.
COMPUTE filter_$=(Current_Status<>"Closed" & Current_Status<>"Suspended").
VARIABLE LABELS filter_$ 'Current_Status<>"Closed" & Current_Status<>"Suspended" (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

DATASET ACTIVATE $DataSet.
SUMMARIZE
  /TABLES=IRB_APPROVAL_TIME BY IRB_APPROVAL_YEAR
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT MEDIAN MEAN MIN MAX RANGE STDDEV.

SUMMARIZE
  /TABLES=IRB_APPROVAL_TIME BY IRB_APPROVAL_YEAR BY Review_Type
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT MEDIAN MEAN MIN MAX RANGE STDDEV.
