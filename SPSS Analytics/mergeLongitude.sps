* Encoding: UTF-8.


GET
  FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\RespMaster.sav'.
DATASET NAME $DataSet WINDOW=FRONT.




MATCH FILES
  /FILE=*
  / FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2011_Longitude.sav'
  /BY Respondent.
EXECUTE.

MATCH FILES
  /FILE=*
  / FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2012_Longitude.sav'
  /BY Respondent.
EXECUTE.

MATCH FILES
  /FILE=*
  / FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2013_Longitude.sav'
  /BY Respondent.
EXECUTE.

MATCH FILES
  /FILE=*
  / FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2014_Longitude.sav'
  /BY Respondent.
EXECUTE.

MATCH FILES
  /FILE=*
  / FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2015_Longitude.sav'
  /BY Respondent.
EXECUTE.

MATCH FILES
  /FILE=*
  / FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2016_Longitude.sav'
  /BY Respondent.
EXECUTE.

RECODE merge2011 merge2012 merge2013 merge2014 merge2015 merge2016 (SYSMIS=0).
EXECUTE.

SELECT IF merge2011=1 | merge2012=1 | merge2013=1 | merge2014=1 | merge2015=1 | merge2016=1. 
EXECUTE.

SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2011-16_Longitude.sav'
  /COMPRESSED.








