GET   FILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\ARF1 ARF2 MASTER.sav'.
*** open file here.
** OPEN ARF_MASTER FILE HERE


COMPUTE SHBath = 0 .
COMPUTE SHDres = 0 .
COMPUTE SHEati = 0 .
COMPUTE SHToil = 0 .
COMPUTE SHTran = 0 .
COMPUTE SHWalk = 0 .

IF (ADL_BATH>=3) SHBath = 1 .
IF (ADL_DRES>=3) SHDres = 1 .
IF (ADL_EAT>=3)  SHEati = 1 .
IF (ADL_TOIL>=3) SHToil = 1 .
IF (ADL_TRAN>=3 ) SHTran = 1 .
IF (ADL_WALK>=3) SHWalk = 1 .

COMPUTE THBath = 0 .
COMPUTE THDres = 0 .
COMPUTE THEati = 0 .
COMPUTE THToil = 0 .
COMPUTE THTran = 0 .
COMPUTE THWalk = 0 .

IF (ADL_BATH>=4) THBath = 1 .
IF (ADL_DRES>=4) THDres = 1 .
IF (ADL_EAT>=4)  THEati = 1 .
IF (ADL_TOIL>=4) THToil = 1 .
IF (ADL_TRAN>=4 ) THTran = 1 .
IF (ADL_WALK>=4) THWalk = 1 .
COMPUTE THelp = thbath+thdres+theati+thtoil+thtran+thwalk .
COMPUTE SHelp = shbath+shdres+sheati+shtoil+shtran+shwalk .


COMPUTE divelig=0.
EXECUTE .

**** MEDICAID FINANCIAL ELIGIBILITY - WE AREN'T CHECKING - ASSUME ARE FINANCIALLY ELIGIBLE***.
COMPUTE FINELIG=1.
EXECUTE.
*IF INCOME<1656 & ASSETS='M' FINELIG=1.
*EXECUTE.
****compute some help with 5+ adl**************.
IF  (SHelp >= 5) DIVELIG=1 .
EXECUTE.
**********compute total help with 2+adl******************.
IF  (THelp>=2) DIVELIG=1 .
EXECUTE. 
*********compute some help with 4 and medication****************.
IF  (SHelp>=4 & IADL_MED>=2) DIVELIG=1.
EXECUTE.
*************************some help with 3+ adl & dementia*******************.
IF  (SHelp>=3 &  DEMENT = "Y") DIVELIG =1.
EXECUTE.

COMPUTE MLTCPROB=0.
IF FINELIG=1 & DIVELIG=1 MLTCPROB=1.
EXECUTE.

COMPUTE UNDUP=1.
SORT CASES BY SSN (A) MLTCPROB (D).
EXECUTE.
IF (SSN)=LAG(SSN) UNDUP=0.
EXECUTE.
SELECT IF UNDUP=1.
EXECUTE.


*** GET RID OF EVERYTHING WHERE DIVELIG ISN'T = 1.
SELECT IF DIVELIG=1.
EXECUTE.

SAVE OUTFILE='C:\Documents and Settings\user\Desktop\EdNeuRates2013\DIVELIG_2013.sav'
    /KEEP SSN DIVELIG  /COMPRESSED.





