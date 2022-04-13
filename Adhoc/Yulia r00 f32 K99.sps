﻿* Encoding: UTF-8.
* Encoding: UTF-8.
GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=DSP Click IS BASE;Description=Sponsored Program PS '+
    'Views;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Intel Compiler '+
    '19.1;WSID=FCTR-3236-W2;DATABASE=IS_BaseData'
  /SQL='SELECT CLK_PROPOSAL_ID, CLK_PI_UFID, CLK_PI_NAME, CLK_TITLE, CLK_DESCRIPTION, '+
    'CLK_CURRENTSTATE, CLK_PS_AWARD_ID, CLK_SPONSOR_AWARD_ID, CLK_FINAL_AGENCY, CLK_APP_TYPE, '+
    'CLK_REV_TYPE_INCREASE_AWARD, CLK_REV_TYPE_DECREASE_DURATION, CLK_REV_TYPE_INCREASE_DURATION, '+
    'CLK_REV_TYPE_DECREASE_AWARD, CLK_REV_TYPE_OTHER, CLK_REV_OTHER_SPECIFY, '+
    'CLK_FEDERAL_IDENTIFIER, CLK_OPPORTUNITY_ID, CLK_CFDA, CLK_OPPORTUNITY_TITLE, '+
    'CLK_COMPETITION_ID, CLK_OTHER_SOLICITATION, CLK_SOLICITATION_SPONSOR_ID, '+
    'CLK_SOLICITATION_SPONSOR, CLK_SOLICITATION_DESC, CLK_SOLICITATION_NUM, CLK_PI_HOME_DEPT_ID, '+
    'CLK_PI_HOME_DEPT, CLK_PI_HOME_COLLEGE_ID, CLK_PI_HOME_COLLEGE, CLK_MENTOR_UFID, '+
    'CLK_MENTOR_NAME, CLK_SUBMITTING_DEPT_ID, CLK_SUBMITTING_DEPARTMENT, '+
    'CLK_SUBMITTING_COLLEGE_ID, CLK_SUBMITTING_COLLEGE, CLK_SPONSOR_ID, CLK_SPONSOR_NAME, '+
    'CLK_SPONSOR_CATEGORY, CLK_PRIMARY_SPONSOR_NAME, CLK_PRIMARY_SPONSOR_ID, '+
    'CLK_REPORTING_SPONSOR_ID, CLK_REPORTING_SPONSOR_NAME, CLK_REPORTING_SPONSOR_CATEGORY, '+
    'CLK_SPONSORNAMENOTINLIST_NAME, CLK_TOTAL_DIRECT_COSTS, CLK_TOTAL_INDIRECT_COSTS, '+
    'CLK_GRAND_TOTAL, CLK_TOTAL_DIRECT_COSTSHARE, CLK_TOTAL_INDIRECT_COSTSHARE, '+
    'CLK_GRAND_TOTAL_COSTSHARE, CLK_GRAND_TOTAL_CS_ORIGSUBM, CLK_GRAND_TOTAL_ORIGSUBM, '+
    'CLK_TOTAL_DIRECT_CS_ORIGSUBM, CLK_TOTAL_DIRECT_ORIGSUBM, CLK_TOTAL_INDIRECT_CS_ORIGSUBM, '+
    'CLK_TOTAL_INDIRECT_ORIGSUBM, CLK_HUMAN_SUBJECTS, CLK_LAB_ANIMALS, '+
    'CLK_CLINICAL_SERVICES_REQUIRED, CLK_DEADLINE, CLK_NODEADLINE, CLK_DSP_OWNER_UFID, '+
    'CLK_DSP_OWNER, TEAMS, CLK_DSP_OWNER_EMAIL, CLK_DSP_OWNER_PHONE, '+
    'CLK_PRIMARY_UNIT_CONTACT_UFID, CLK_PRIMARY_UNIT_CONTACT, CLK_PRIMARY_UNIT_EMAIL, '+
    'CLK_PRIMARY_UNIT_PHONE, CLK_LIMITED_OPPORTUNITY, CLK_PURPOSE, CLK_DSP5_ATTACHED, '+
    'CLK_SUBMITTED_WO_DSP_APPRVL, CLK_SUBMITTED_WO_UNIT_APPRVL, CLK_NO_PROP_SUBMITTED, '+
    'CLK_SUBMITTED_WO_SFI_DISCL, CLK_ADDNL_SUBMISSIONS, CLK_PROJECT_STARTS, CLK_PROJECT_ENDS, '+
    'CLK_PROJ_PERIODS, CLK_PROJ_LENGTH, CLK_PEER_REVIEW_PROCESS, CLK_INST_TRAIN_GRANT, '+
    'CLK_KEYWORDS, CLK_APPRVL_ITEMS_DTL, CLK_APPRVL_ITEMS_NONE, CLK_APPRVL_ITEMS_OTHER, '+
    'CLK_APPRVL_ITEMS_PURCHASE, CLK_APPRVL_ITEMS_SPACE, CLK_EMPLOYED_BY, '+
    'CLK_IRB_DIRECT_INTERACTION, CLK_IRB_DEIDENTIFIED_DATA, CLK_IRB_PROTOCOL_NUM, CLK_IRB_APPV, '+
    'CLK_IRB_STATUS, CLK_IRB_EXEMPTION_NUM_E1, CLK_IRB_EXEMPTION_NUM_E2, CLK_IRB_EXEMPTION_NUM_E3, '+
    'CLK_IRB_EXEMPTION_NUM_E4, CLK_IRB_EXEMPTION_NUM_E5, CLK_IRB_EXEMPTION_NUM_E6, CLK_IACUC_APPV, '+
    'CLK_IACUC_STATUS, CLK_IACUC_PROTOCOL_NUM, CLK_HOWAPPSUBMITTED, CLK_HOW, '+
    'CLK_SUBRECIPIENTNAMENOTINLIST, CLK_SUBRECIP_ORG, CLK_THIRDPARTY_NAMENOTINLIST, '+
    'CLK_THIRDPARTY_COL, CLK_INTL_CLB, CLK_INTL_CLB_COUNTRIES, CLK_INTL_CLB_EXPLAIN, '+
    'CLK_PRO_DATE_SUBMITTED, CLK_PRO_IS_P3_CLIN_TRIAL, CLK_PRO_RESEARCH_PRCNT, '+
    'CLK_PRO_INSTRUCTION_PRCNT, CLK_PRO_EXTENSION_PRCNT, CLK_PRO_SPON_ACT_PRCNT, CLK_PRO_FED, '+
    'CLK_PRO_PROJECT_TYPE, CLK_PRIMARY_SPONSOR_CAT, CLK_PRO_DEADLINE_TYPE, LASTUPD_EW_DTTM, '+
    'CLK_CURRENTSTATE_NAME FROM IS_BaseData.Base.vwWH_CLICK_PROPOSAL_DETAIL'
  /ASSUMEDSTRWIDTH=255.

CACHE.
EXECUTE.




String KeepRec (A12).

COMPUTE KeepRec="Omit".
EXECUTE.


IF Char.Index(CLK_FEDERAL_IDENTIFIER,"F32")<>0  KeepRec="F32".
IF Char.Index(CLK_FEDERAL_IDENTIFIER,"R00")<>0  KeepRec="R00".
IF Char.Index(CLK_FEDERAL_IDENTIFIER,"K99")<>0  KeepRec="K99".
IF Char.Index(CLK_OPPORTUNITY_TITLE,"Kirschstein")<>0  KeepRec="Kirshstein".
IF Char.Index(CLK_OPPORTUNITY_TITLE,"Fellowship")<>0  KeepRec="FellowShip".

IF Char.Index(CLK_SPONSOR_NAME,"NATL INST OF HLTH")=0  KeepRec="Omit".
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (KeepRec<>"Omit").
EXECUTE.


SAVE TRANSLATE OUTFILE='V:\Projects\EdNeu\Yulia\Proposal F32 R00 K99 20220121.xlsx'
	/TYPE=XLS					
	/VERSION=12					
	/MAP					
	/FIELDNAMES VALUE=NAMES				
	/CELLS=VALUES					
	/REPLACE.					


