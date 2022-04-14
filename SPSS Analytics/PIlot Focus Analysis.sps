* Encoding: UTF-8.

COMPUTE HAS_PUB=0.
COMPUTE HAS_GRANT=0.

IF (Pub2012=1 | Pub2013=1 | Pub2014=1 | Pub2015=1 | Pub2016=1) HAS_PUB=1.
IF (Grant2012=1 | Grant2013=1 | Grant2014=1 | Grant2015=1 | Grant2016=1) HAS_GRANT=1.
EXECUTE.


*COMPUTE PUB_LAG=2016-Award_Year.
*COMPUTE GRANT_LAG=2016-Award_Year.
*EXECUTE.

IF HAS_PUB=1  PUB_LAG=PubYear-Award_Year.
IF HAS_GRANT=1 GRANT_LAG=GrantYear-Award_Year.
EXECUTE.

USE ALL.
FILTER BY HAS_PUB=1.
EXECUTE.

USE ALL.
COMPUTE filter_$=(HAS_PUB=1).
VARIABLE LABELS filter_$ 'HAS_PUB=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

RECODE GrantYear PubYear (SYSMIS=0).
EXECUTE.



COMPUTE TEST=PubYear--PubYear.
EXECUTE.

COMPUTE TEST2=GrantYear--GrantYear.
EXECUTE.

COMPUTE TEST3=Award_Year-Award_Year.
EXECUTE.

DATASET ACTIVATE DataSet1.
USE ALL.
COMPUTE filter_$=(HAS_PUB=0 & (Award_Year=2012 OR Award_Year=2013 or Award_Year=2014)).
VARIABLE LABELS filter_$ 'HAS_PUB=0 & (Award_Year=2012 OR Award_Year=2013 or Award_Year=2014) '+
    '(FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

USE ALL.
COMPUTE filter_$=(HAS_PUB=0 & (Award_Year=2012 OR Award_Year=2013 or Award_Year=2014) & 
    (Institution='U Florida; Cornell U' OR Institution='UF' OR Institution='UF; Portland State U') ).
VARIABLE LABELS filter_$ "HAS_PUB=0 & (Award_Year=2012 OR Award_Year=2013 or Award_Year=2014) & "+
    "(Institution='U Florida; Cornell U' OR Institution='UF' OR Institution='UF; Portland State "+
    "U')  (FILTER)".
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
