* Encoding: UTF-8.


BarrierContract_2016
BarrierIRB_2016
BarrierRAC_2016
BarrierRecruitment_2016

RECODE BarrierContract_2016
BarrierIRB_2016
BarrierRAC_2016
BarrierRecruitment_2016 
  (5=4).
EXECUTE.

RECODE BarrierContract_2016
BarrierIRB_2016
BarrierRAC_2016
BarrierRecruitment_2016  (6=5).
EXECUTE.


Value Labels
BarrierContract_2016
BarrierIRB_2016
BarrierRAC_2016
BarrierRecruitment_2016 
1 'Not a Barrier'
2 'Slight Barrier'
3 'Moderate Barrier'
4 'Serious Barrier' 
5 'Extreme Barrier'.
EXECUTE.
