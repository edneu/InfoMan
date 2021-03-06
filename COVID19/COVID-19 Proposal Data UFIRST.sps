﻿* Encoding: UTF-8.
^^GET DATA
**  /TYPE=ODBC
**  /CONNECT='DSN=DSP Click IS BASE;Description=Sponsored Program PS '+
**    'Views;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
**    'Common;WSID=FCTR-3236-W2;DATABASE=IS_BaseData'.
  

COMPUTE COVID_Flag=0.
EXECUTE.

IF CHAR.INDEX(CLK_TITLE,"COVID")<>0 COVID_Flag=1.
IF CHAR.INDEX (CLK_SOLICITATION_DESC,"COVID")<>0 COVID_Flag=1.
IF CHAR.INDEX (CLK_DESCRIPTION,"COVID")<>0 COVID_Flag=1.
IF CHAR.INDEX (CLK_OPPORTUNITY_TITLE,"COVID")<>0 COVID_Flag=1.
IF CHAR.INDEX (CLK_OTHER_SOLICITATION,"COVID")<>0 COVID_Flag=1.

EXECUTE.


FREQUENCIES VARIABLES=COVID_Flag   /ORDER=ANALYSIS.


FILTER OFF.
USE ALL.
SELECT IF (COVID_Flag=1).
EXECUTE.


***SAVE TRANSLATE OUTFILE='P:\My Documents\My Documents\LoadData\COVID-19 UFirst Proposal Detail 20200708.xlsx'
SAVE TRANSLATE OUTFILE='P:\My Documents\My Documents\LoadData\COVID-19 UFirst Proposal Detail 20200708.xlsx'

SAVE TRANSLATE OUTFILE='V:\Projects\EdNeu\COVID 19 Task Force\COVID-19 UFirst Proposal Detail 20210203.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
  /REPLACE
   /KEEP=CLK_PROPOSAL_ID
CLK_TITLE
CLK_PI_NAME
CLK_SPONSOR_NAME   
CLK_CURRENTSTATE
CLK_DEADLINE
CLK_TOTAL_DIRECT_COSTS
CLK_TOTAL_INDIRECT_COSTS
CLK_GRAND_TOTAL
CLK_DESCRIPTION
CLK_PS_AWARD_ID
CLK_SPONSOR_AWARD_ID
CLK_APP_TYPE
CLK_PI_HOME_DEPT
CLK_PI_HOME_COLLEGE
CLK_PRIMARY_UNIT_CONTACT
CLK_PRIMARY_UNIT_EMAIL
CLK_PRIMARY_UNIT_PHONE
CLK_KEYWORDS
CLK_HUMAN_SUBJECTS
CLK_LAB_ANIMALS
CLK_PI_UFID
COVID_Flag.



