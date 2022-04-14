* Encoding: UTF-8.
**********************************************************************************************************************************************************.
** 2011

GET   FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2011_Final.sav'.

SORT CASES BY Survey_ID (A).


MATCH FILES
  /FILE=*
  /FILE= 'C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\RespLookup.sav' 
  /BY Survey_ID.
EXECUTE.


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2011_Final.sav'
  /COMPRESSED /DROP Email, Name, eRA_Commons_Username, PIN.

**********************************************************************************************************************************************************.
** 2012.


GET   FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2012_Final.sav'.

SORT CASES BY Survey_ID (A).


MATCH FILES
  /FILE=*
  /FILE= 'C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\RespLookup.sav' 
  /BY Survey_ID.
EXECUTE.


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2012_Final.sav'
  /COMPRESSED /DROP Email, Name, LastName, FirstName.


**********************************************************************************************************************************************************.
** 2013.


GET   FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2013_Final.sav'.

SORT CASES BY Survey_ID (A).


MATCH FILES
  /FILE=*
  /FILE= 'C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\RespLookup.sav' 
  /BY Survey_ID.
EXECUTE.


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2013_Final.sav'
  /COMPRESSED /DROP Lastname, FirstName, role, UFID, Email.





**********************************************************************************************************************************************************.
** 2014.


GET   FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2014_Final.sav'.

SORT CASES BY Survey_ID (A).


MATCH FILES
  /FILE=*
  /FILE= 'C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\RespLookup.sav' 
  /BY Survey_ID.
EXECUTE.


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2014_Final.sav'
  /COMPRESSED /DROP NAME, EMAIL 


**********************************************************************************************************************************************************.
** 2015.


GET   FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2015_Final.sav'.

SORT CASES BY Survey_ID (A).


MATCH FILES
  /FILE=*
  /FILE= 'C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\RespLookup.sav' 
  /BY Survey_ID.
EXECUTE.


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2015_Final.sav'
  /COMPRESSED /DROP NAME, EMAIL 



**********************************************************************************************************************************************************.
** 2016.


GET   FILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2016_Final.sav'.

SORT CASES BY Survey_ID (A).


MATCH FILES
  /FILE=*
  /FILE= 'C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\RespLookup.sav' 
  /BY Survey_ID.
EXECUTE.


SAVE OUTFILE='C:\Users\edneu\Dropbox\CTSI\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\Longitude\CTSI_2016_Final.sav'
  /COMPRESSED /DROP NAME, EMAIL 


