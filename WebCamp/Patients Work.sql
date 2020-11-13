

SELECT * from ctsi_webcamp_pr.patient
WHERE UNIQUEFIELD IN  
	(Select Distinct Patient from ctsi_webcamp_pr.opvisit
		WHERE Visitdate>=CURDATE()   and Status in (1,2))
;
