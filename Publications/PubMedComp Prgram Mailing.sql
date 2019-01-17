

SELECT pubmaster_id2,Citation,CTSI_GRANT,Grant_Numbers
from pubs.PUB_CORE
WHERE pubmaster_id2 IN (166,
172,
178,
297,
358,
393,
456,
464,
482,
487,
503,
508,
509,
510,
528,
535,
555,
573,
582,
611,
614,
616,
619,
620,
622,
631,
640,
641,
648,
656,
660,
665,
670,
671,
673,
683,
687,
689,
690,
695,
701,
702,
706,
708,
711,
719,
720,
721,
722,
730
);


SELECT pubmaster_id2,Citation,CTSI_GRANT,Grant_Numbers
from pubs.PUB_CORE
WHERE pubmaster_id2 IN (482,487,178,640);

SELECT *
from pubs.PUB_CORE
WHERE pubmaster_id2 IN (482,487,178,640);
