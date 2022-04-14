
**************************************************************************************************************.
**************************************************************************************************************.
**************************************************************************************************************.
***************************************************************************************************************.
***************************************************************************************************************.
********                                                                                     ***********************************.
********                         CREATE MCLAIMS 1112                       ***********************************.
********                                                                                     ***********************************.
***************************************************************************************************************.
***************************************************************************************************************.
***************************************************************************************************************.
***************************************************************************************************************.
***************************************************************************************************************.
*
* CREATE ELIGIBILITY FILE.





GET DATA  /TYPE=TXT
  /FILE="C:\Documents and Settings\user\Desktop\EdNeuRates2013\CapELIG_FY1112x2.txt"
 /FIXCASE = 1
 /ARRANGEMENT = FIXED
 /FIRSTCASE = 1
 /IMPORTCASE= ALL
 /VARIABLES =
 /1      RECIPID 0-9 A10
          MON_NUM 10-13 F4.0
          SSN 14-22 A9
          DISTRICT 23-24 A2
          COUNTY 25-26 A2
          AGECAT 27-27 A1
          ELIG 28-28 A1
          ELIGOR 29-29 A1
          HMO 30-30 A1
          NH 31-31 A1
          MP 32-32 A1
          AIDS 33-33 A1
          CMS 34-34 A1
          ORGANTRANS 35-35 A1
          MCHMO 36-37 A2
          AGE 38-40 F3.0
          PGMCD 41-44 A4
          SEX 45-45 A1
          ADM 46-46 A1
          CWF 47-47 A1
          BHOS 48-48 A1
          SIPP 49-49 A1
          RETRO 50-50 A1
          MCARE 51-51 A1
 .

CACHE.
EXECUTE.

COMPUTE BUCKET=0.
COMPUTE CLAIMS=0.
COMPUTE UNITS=0.
COMPUTE AMOUNT=0.
EXECUTE.


SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\ELIG1112.sav'
/KEEP RECIPID SSN MON_NUM, DISTRICT AGE MCARE ELIG BUCKET CLAIMS UNITS AMOUNT
 /COMPRESSED.

SUMMARIZE
  /TABLES=AMOUNT BY BUCKET
  /FORMAT=NOLIST TOTAL
  /TITLE='Eligibility File'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN SUM MIN MAX.



* Create PART D&B Replacement Data **.

GET DATA  /TYPE=TXT
  /FILE="C:\Documents and Settings\user\Desktop\EdNeuRates2013\part_D_B_drug1112_56.txt"
 /FIXCASE = 1
 /ARRANGEMENT = FIXED
 /FIRSTCASE = 1
 /IMPORTCASE=  ALL
 /VARIABLES =
 /1       RECIPID 0-9 A10
          MON_NUM 10-11 F2.0
          BUCKET 12-13 F2.0
          CLAIMS 14-19 F6.0
          UNITS 20-25 F6.0
          AMOUNT 26-37 F12.2
          SSN 38-46 A9
          SEX 47-47 A1
          RACE 48-48 A1
          AGE 49-51 F3.0
          DOB 52-59 A8
          DISTRICT 60-61 A2
          COUNTY 62-63 A2
          ZIP 64-68 A5
          PGMCD 69-72 A4
          ELIG 73-73 A1
          HMO 74-74 A1
          NH 75-75 A1
          MP 76-76 A1
          MCARE 77-77 A1
          MCHMO 78-79 A2
          AGECAT 80-80 A1
          AIDS 81-81 A1
          CMS 82-82 A1
          ORGANTRANS 83-83 A1


 .

CACHE.
EXECUTE.

** FREQUENCIES VARIABLES=mon_num sex race area county acwm elig mcare   /ORDER=ANALYSIS.


SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\PARTDB1112.sav' 
/KEEP RECIPID SSN MON_NUM, DISTRICT AGE MCARE ELIG BUCKET CLAIMS UNITS AMOUNT
 /COMPRESSED.

SUMMARIZE
  /TABLES=AMOUNT BY BUCKET
  /FORMAT=NOLIST TOTAL
  /TITLE='Part DB File'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN SUM MIN MAX.

*** LOAD CLAIMS FILE ****************************************************.

GET DATA  /TYPE=TXT
  /FILE="C:\Documents and Settings\user\Desktop\EdNeuRates2013\CAP_CLAIMfy1112x2.txt"
 /FIXCASE = 1
 /ARRANGEMENT = FIXED
 /FIRSTCASE = 1
 /IMPORTCASE=  ALL
 /VARIABLES =
 /1             RECIPID 0-9 A10
          MON_NUM 10-13 F4.0
          SSN 14-22 A9
          DISTRICT 23-24 A2
          COUNTY 25-26 A2
          ELIG 27-27 A1
          ELIGOR 28-28 A1
          HMO 29-29 A1
          NH 30-30 A1
          MP 31-31 A1
          AIDS 32-32 A1
          CMS 33-33 A1
          ORGANTRANS 34-34 A1
          MCHMO 35-36 A2
          AGE 37-39 F3.0
          PGMCD 40-43 A4
          SEX 44-44 A1
          BUCKET 45-46 F2.0
          CLAIMS 47-47 F1.0
          UNITS 48-52 F5.0
          AMOUNT 53-64 F12.2
          AGECAT 65-65 A1
          ADM 66-66 A1
          CWF 67-67 A1
          BHOS 68-68 A1
          SIPP 69-69 A1
          RETRO 70-70 A1
          PILOT 71-71 A1
 .
CACHE.
EXECUTE.

STRING MCARE (A1).
COMPUTE MCARE='0'.
IF ELIG='4' MCARE='4'.
IF ELIG='5' MCARE='5'.
EXECUTE.

SELECT IF (BUCKET~=14) | (BUCKET=14 & MCARE='0').
EXECUTE .

SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CAPCLAIM1112.sav'   
/KEEP RECIPID SSN MON_NUM, DISTRICT AGE MCARE ELIG BUCKET CLAIMS UNITS AMOUNT
/COMPRESSED.

GET FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CAPCLAIM1112.sav'   .

SUMMARIZE
  /TABLES=AMOUNT BY BUCKET
  /FORMAT=NOLIST TOTAL
  /TITLE='Claims File'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN SUM MIN MAX.


ADD FILES /FILE=*
/FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\PARTDB1112.sav'.

ADD FILES /FILE=*
/FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\\ELIG1112.sav'.
EXECUTE.



STRING SFY(A7).
COMPUTE SFY='2011-12'.
STRING MONTH(A7).
IF MON_NUM=1 MONTH='2011-07'.
IF MON_NUM=2 MONTH='2011-08'.
IF MON_NUM=3 MONTH='2011-09'.
IF MON_NUM=4 MONTH='2011-10'.
IF MON_NUM=5 MONTH='2011-11'.
IF MON_NUM=6 MONTH='2011-12'.
IF MON_NUM=7 MONTH='2012-01'.
IF MON_NUM=8 MONTH='2012-02'.
IF MON_NUM=9 MONTH='2012-03'.
IF MON_NUM=10 MONTH='2012-04'.
IF MON_NUM=11 MONTH='2012-05'.
IF MON_NUM=12 MONTH='2012-06'.
Execute.

******************************************************************.
***** DIVERSION ELIGIBLE. ARF and NHLOC          *****.
******************************************************************.



SORT CASES BY SSN (A).

MATCH FILES /FILE=*
/TABLE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\DIVELIG_2013.sav'
 /BY SSN.
EXECUTE.

MATCH FILES /FILE=*
 /TABLE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\NH_LOC_2013.sav'
 /BY SSN.
EXECUTE.

MATCH FILES /FILE=*
 /TABLE=='C:\Documents and Settings\user\Desktop\EdNeuRates2013\ARF_2013.sav'
 /BY SSN.
EXECUTE.

RECODE    divelig NH_LOC (SYSMIS=0).
RECODE    ARF ARF2 (SYSMIS=1) .
EXECUTE .

SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\MCLAIM1112.sav'   
  /COMPRESSED.

SUMMARIZE
  /TABLES=AMOUNT BY BUCKET
  /FORMAT=NOLIST TOTAL
  /TITLE='Merged Claims File'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN SUM MIN MAX.
*****************************************************************************************************************.
*****************************************************************************************************************.
************** MW PARTICIPATION                                                                ***********************.
*****************************************************************************************************************.

GET   FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\MCLAIM1112.sav'  

SELECT IF BUCKET=5 | BUCKET=6 | BUCKET=7 | BUCKET=8 | BUCKET=35 | BUCKET=61.

COMPUTE ADA_MON=0.
COMPUTE ALE_MON=0.
COMPUTE NH_MON=0.

IF BUCKET=35 ADA_MON=1.
IF BUCKET=61 ALE_MON=1.
IF BUCKET>=5 & BUCKET<=8 NH_MON=1.
EXECUTE.

SORT CASES BY SFY (a)  MONTH (a)  RECIPID (a).

SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\LTC_BUCK_ONLY.sav'   /COMPRESSED.


AGGREGATE
  /OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\ltc_mon.sav'
  /PRESORTED
  /BREAK=SFY MONTH RECIPID
  /ADA_MON= MAX(ADA_mon) /ALE_MON = MAX(ALE_MON) /NH_MON = MAX(NH_MON).

GET FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\ltc_mon.sav'.

IF NH_MON=1 ALE_MON=0.
IF NH_MON=1 ADA_MON=0.
EXECUTE.
IF ALE_MON=1 & ADA_MON=1 ADA_MON=0.
EXECUTE.

SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\LTC_MON.sav'   /COMPRESSED.

AGGREGATE
  /OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\MW_CM_SFY.sav'
  /BREAK=SFY RECIPID
  /ADA_CM_SFY = SUM(ADA_MON) 
  /ALE_CM_SFY = SUM(ALE_MON)
  /NH_CM_SFY = SUM(NH_MON).


GET FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\MW_CM_SFY.sav'.

*COMPUTE COMM_PCT_SFY=(ALE_CM_SFY+ADA_CM_SFY) / (ALE_CM_SFY+ADA_CM_SFY+NH_CM_SFY).
*COMPUTE NH_PCT_SFY=(NH_CM_SFY) / (ALE_CM_SFY+ADA_CM_SFY+NH_CM_SFY).
COMPUTE COMM_PCT=(ALE_CM_SFY+ADA_CM_SFY) / (ALE_CM_SFY+ADA_CM_SFY+NH_CM_SFY).
COMPUTE NH_PCT=(NH_CM_SFY) / (ALE_CM_SFY+ADA_CM_SFY+NH_CM_SFY).
EXECUTE.

*COMPUTE SFY_1_CPCT=0.
*COMPUTE SFY_2_CPCT=0.
*IF SFY='2011-12' SFY_1_CPCT=COMM_PCT_SFY.
*IF SFY='2011-12' SFY_1_NHPCT=NH_PCT_SFY.
*EXECUTE.


AGGREGATE
  /OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CPCT_SFY_LOOKUP.sav'
  /BREAK=RECIPID
  /CommPct=SUM(COMM_PCT)
  /NhPct=SUM(NH_PCT).


GET FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CPCT_SFY_LOOKUP.sav'.

SORT CASES BY RECIPID (A).

SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CPCT_SFY_LOOKUP.sav'  /COMPRESSED.

GET  FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\MCLAIM1112.sav'  .
SORT CASES BY RECIPID (a).

MATCH FILES /FILE=*
 /TABLE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CPCT_SFY_LOOKUP.sav'
 /BY RECIPID.
EXECUTE.


RECODE   CommPCT  divelig  NhPct (SYSMIS=0).
 EXECUTE .


SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CAPFILE1112.sav'   /COMPRESSED.

*******************************************************************************************************************************************************.
*******************************************************************************************************************************************************.
****************************  PROGRAM MASKS BELOW ***************************************************************************************.
*******************************************************************************************************************************************************.
GET  FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CAPFILE1112.sav'.

COMPUTE NHD_BUCKET=0.
COMPUTE PACE_BUCKET=0.

IF BUCKET=0 NHD_BUCKET=1.
IF BUCKET=1 NHD_BUCKET=1.
IF BUCKET=2 NHD_BUCKET=1.
IF BUCKET=3 NHD_BUCKET=1.
IF BUCKET=4 NHD_BUCKET=1.
IF BUCKET=5 NHD_BUCKET=1.
IF BUCKET=6 NHD_BUCKET=1.
IF BUCKET=7 NHD_BUCKET=1.
IF BUCKET=8 NHD_BUCKET=0.
IF BUCKET=9 NHD_BUCKET=0.
IF BUCKET=10 NHD_BUCKET=0.
IF BUCKET=11 NHD_BUCKET=0.
IF BUCKET=12 NHD_BUCKET=1.
IF BUCKET=13 NHD_BUCKET=1.
IF BUCKET=14 NHD_BUCKET=1.
IF BUCKET=15 NHD_BUCKET=1.
IF BUCKET=16 NHD_BUCKET=1.
IF BUCKET=17 NHD_BUCKET=0.
IF BUCKET=18 NHD_BUCKET=1.
IF BUCKET=19 NHD_BUCKET=0.
IF BUCKET=20 NHD_BUCKET=1.
IF BUCKET=21 NHD_BUCKET=1.
IF BUCKET=22 NHD_BUCKET=0.
IF BUCKET=23 NHD_BUCKET=0.
IF BUCKET=24 NHD_BUCKET=0.
IF BUCKET=25 NHD_BUCKET=0.
IF BUCKET=26 NHD_BUCKET=1.
IF BUCKET=27 NHD_BUCKET=1.
IF BUCKET=28 NHD_BUCKET=1.
IF BUCKET=29 NHD_BUCKET=0.
IF BUCKET=31 NHD_BUCKET=1.
IF BUCKET=32 NHD_BUCKET=1.
IF BUCKET=33 NHD_BUCKET=1.
IF BUCKET=34 NHD_BUCKET=0.
IF BUCKET=35 NHD_BUCKET=1.
IF BUCKET=36 NHD_BUCKET=0.
IF BUCKET=37 NHD_BUCKET=0.
IF BUCKET=38 NHD_BUCKET=0.
IF BUCKET=39 NHD_BUCKET=0.
IF BUCKET=40 NHD_BUCKET=1.
IF BUCKET=41 NHD_BUCKET=1.
IF BUCKET=42 NHD_BUCKET=1.
IF BUCKET=43 NHD_BUCKET=0.
IF BUCKET=44 NHD_BUCKET=1.
IF BUCKET=45 NHD_BUCKET=1.
IF BUCKET=46 NHD_BUCKET=1.
IF BUCKET=47 NHD_BUCKET=1.
IF BUCKET=48 NHD_BUCKET=0.
IF BUCKET=49 NHD_BUCKET=1.
IF BUCKET=52 NHD_BUCKET=0.
IF BUCKET=53 NHD_BUCKET=1.
IF BUCKET=54 NHD_BUCKET=1.
IF BUCKET=56 NHD_BUCKET=0.
IF BUCKET=57 NHD_BUCKET=0.
IF BUCKET=58 NHD_BUCKET=0.
IF BUCKET=59 NHD_BUCKET=0.
IF BUCKET=60 NHD_BUCKET=0.
IF BUCKET=61 NHD_BUCKET=1.
IF BUCKET=62 NHD_BUCKET=1.
IF BUCKET=63 NHD_BUCKET=0.
IF BUCKET=64 NHD_BUCKET=0.
IF BUCKET=65 NHD_BUCKET=1.
IF BUCKET=66 NHD_BUCKET=0.
IF BUCKET=67 NHD_BUCKET=0.
IF BUCKET=68 NHD_BUCKET=0.
IF BUCKET=69 NHD_BUCKET=0.
IF BUCKET=70 NHD_BUCKET=0.
IF BUCKET=71 NHD_BUCKET=1.
IF BUCKET=72 NHD_BUCKET=0.
IF BUCKET=73 NHD_BUCKET=0.
IF BUCKET=74 NHD_BUCKET=0.
IF BUCKET=75 NHD_BUCKET=0.
IF BUCKET=76 NHD_BUCKET=0.
IF BUCKET=77 NHD_BUCKET=0.

IF BUCKET=0 PACE_BUCKET=1.
IF BUCKET=1 PACE_BUCKET=1.
IF BUCKET=2 PACE_BUCKET=1.
IF BUCKET=3 PACE_BUCKET=1.
IF BUCKET=4 PACE_BUCKET=1.
IF BUCKET=5 PACE_BUCKET=1.
IF BUCKET=6 PACE_BUCKET=1.
IF BUCKET=7 PACE_BUCKET=1.
IF BUCKET=8 PACE_BUCKET=0.
IF BUCKET=9 PACE_BUCKET=0.
IF BUCKET=10 PACE_BUCKET=0.
IF BUCKET=11 PACE_BUCKET=0.
IF BUCKET=12 PACE_BUCKET=1.
IF BUCKET=13 PACE_BUCKET=1.
IF BUCKET=14 PACE_BUCKET=1.
IF BUCKET=15 PACE_BUCKET=1.
IF BUCKET=16 PACE_BUCKET=1.
IF BUCKET=17 PACE_BUCKET=1.
IF BUCKET=18 PACE_BUCKET=1.
IF BUCKET=19 PACE_BUCKET=0.
IF BUCKET=20 PACE_BUCKET=1.
IF BUCKET=21 PACE_BUCKET=1.
IF BUCKET=22 PACE_BUCKET=0.
IF BUCKET=23 PACE_BUCKET=0.
IF BUCKET=24 PACE_BUCKET=0.
IF BUCKET=25 PACE_BUCKET=0.
IF BUCKET=26 PACE_BUCKET=1.
IF BUCKET=27 PACE_BUCKET=1.
IF BUCKET=28 PACE_BUCKET=1.
IF BUCKET=29 PACE_BUCKET=0.
IF BUCKET=31 PACE_BUCKET=1.
IF BUCKET=32 PACE_BUCKET=1.
IF BUCKET=33 PACE_BUCKET=1.
IF BUCKET=34 PACE_BUCKET=0.
IF BUCKET=35 PACE_BUCKET=1.
IF BUCKET=36 PACE_BUCKET=0.
IF BUCKET=37 PACE_BUCKET=0.
IF BUCKET=38 PACE_BUCKET=0.
IF BUCKET=39 PACE_BUCKET=0.
IF BUCKET=40 PACE_BUCKET=1.
IF BUCKET=41 PACE_BUCKET=1.
IF BUCKET=42 PACE_BUCKET=1.
IF BUCKET=43 PACE_BUCKET=0.
IF BUCKET=44 PACE_BUCKET=1.
IF BUCKET=45 PACE_BUCKET=1.
IF BUCKET=46 PACE_BUCKET=1.
IF BUCKET=47 PACE_BUCKET=1.
IF BUCKET=48 PACE_BUCKET=0.
IF BUCKET=49 PACE_BUCKET=1.
IF BUCKET=52 PACE_BUCKET=0.
IF BUCKET=53 PACE_BUCKET=1.
IF BUCKET=54 PACE_BUCKET=1.
IF BUCKET=56 PACE_BUCKET=0.
IF BUCKET=57 PACE_BUCKET=0.
IF BUCKET=58 PACE_BUCKET=0.
IF BUCKET=59 PACE_BUCKET=0.
IF BUCKET=60 PACE_BUCKET=0.
IF BUCKET=61 PACE_BUCKET=1.
IF BUCKET=62 PACE_BUCKET=1.
IF BUCKET=63 PACE_BUCKET=0.
IF BUCKET=64 PACE_BUCKET=0.
IF BUCKET=65 PACE_BUCKET=1.
IF BUCKET=66 PACE_BUCKET=0.
IF BUCKET=67 PACE_BUCKET=0.
IF BUCKET=68 PACE_BUCKET=0.
IF BUCKET=69 PACE_BUCKET=0.
IF BUCKET=70 PACE_BUCKET=0.
IF BUCKET=71 PACE_BUCKET=1.
IF BUCKET=72 PACE_BUCKET=0.
IF BUCKET=73 PACE_BUCKET=0.
IF BUCKET=74 PACE_BUCKET=0.
IF BUCKET=75 PACE_BUCKET=0.
IF BUCKET=76 PACE_BUCKET=0.
IF BUCKET=77 PACE_BUCKET=0.



Execute.

SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\CAPFILE1112.sav' /COMPRESSED.



****************************************************************************.
********************************************* MAKE CAP ENDS HERE ....


FREQUENCIES VARIABLES=bucket mon_num MONTH DISTRICT BUCKET divelig mcare CommPct NH_LOC NHD_BUCKET PACE_BUCKET SFY
  /ORDER=ANALYSIS.



CROSSTABS
  /TABLES=divelig  BY SFY
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


DESCRIPTIVES VARIABLES=CommPct NhPct 
  /STATISTICS=MEAN STDDEV MIN MAX.

SUMMARIZE
  /TABLES=AMOUNT BY BUCKET
  /FORMAT=NOLIST TOTAL
  /TITLE='Capitation File'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN SUM MIN MAX.


CROSSTABS
  /TABLES=MCARE BY ELIG
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.
