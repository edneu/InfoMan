* Encoding: UTF-8.
*** 2011.

GET FILE='P:\My Documents\My Documents\LoadData\CTSI Annual Surveys\CTSI Annual Survey Data 2011.sav'.

STRING Survey_ID (A10).
COMPUTE Survey_ID=CONCAT("2011","-",LTRIM(STRING($CASENUM,n5))).
EXECUTE.


AGGREGATE
  /OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\Longitude\2011Concord.sav'
  /BREAK=Email Survey_ID
  /Name=FIRST(Name).


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\CTSI_2011_Final.sav'
  /COMPRESSED.

*** 2012.
GET FILE='P:\My Documents\My Documents\LoadData\CTSI Annual Surveys\CTSI Annual Survey Data 2012.sav'.

STRING Survey_ID (A10).
COMPUTE Survey_ID=CONCAT("2012","-",LTRIM(STRING($CASENUM,n5))).
EXECUTE.


AGGREGATE
  /OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\Longitude\2012Concord.sav'
  /BREAK=Email Survey_ID
  /Name=FIRST(Name).


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\CTSI_2012_Final.sav'
  /COMPRESSED.

** 2013.
GET FILE='P:\My Documents\My Documents\LoadData\CTSI Annual Surveys\CTSI Annual Survey Data 2013.sav'.

STRING Survey_ID (A10).
COMPUTE Survey_ID=CONCAT("2013","-",LTRIM(STRING($CASENUM,n5))).
EXECUTE.


AGGREGATE
  /OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\Longitude\2013Concord.sav'
  /BREAK=Email Survey_ID
  /Name=FIRST(Name).


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\CTSI_2013_Final.sav'
  /COMPRESSED.



*** 2014.
GET  FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2014_Final.sav'.

STRING Survey_ID (A10).
COMPUTE Survey_ID=CONCAT("2014","-",LTRIM(STRING($CASENUM,n5))).
EXECUTE.


AGGREGATE
  /OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\Longitude\2014Concord.sav'
  /BREAK=Email Survey_ID
  /Name=FIRST(Name).


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\CTSI_2014_Final.sav'
  /COMPRESSED.


*** 2015.
GET  FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2015_Final.sav'.

STRING Survey_ID (A10).
COMPUTE Survey_ID=CONCAT("2015","-",LTRIM(STRING($CASENUM,n5))).
EXECUTE.


AGGREGATE
  /OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\Longitude\2015Concord.sav'
  /BREAK=Email Survey_ID
  /Name=FIRST(Name).


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\CTSI_2015_Final.sav'
  /COMPRESSED.


** 2016.
GET  FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2016_Final.sav'.

STRING Survey_ID (A10).
COMPUTE Survey_ID=CONCAT("2016","-",LTRIM(STRING($CASENUM,n5))).
EXECUTE.


AGGREGATE
  /OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\Longitude\2016Concord.sav'
  /BREAK=Email Survey_ID
  /Name=FIRST(Name).


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\CTSI_2016_Final.sav'
  /COMPRESSED.


