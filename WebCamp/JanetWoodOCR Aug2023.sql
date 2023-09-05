

select * from ctsi_webcamp_pr.protocol;

desc ctsi_webcamp_pr.protocol;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.HasOCR;
Create table ctsi_webcamp_adhoc.HasOCR as
SELECT 
	pt.UNIQUEFIELD as ProtocolNum,
	pt.PROTOCOL as CRCNum,
	pt.U_OCRNO as OCR_Num,
    CONCAT(ps.LASTNAME,", ",ps.FIRSTNAME) as PI_NAME,
	pt.TITLE as ProtocolName
FROM ctsi_webcamp_pr.protocol pt 
	LEFT JOIN ctsi_webcamp_pr.person ps 
    ON pt.PERSON=ps.UNIQUEFIELD 
WHERE pt.U_OCRNO IS NOT NULL
AND pt.PROTOCOL not like "%CS:%"
#### AND DATECLOSEDTOACCRUAL>=str_to_date('07,01,2022','%m,%d,%Y')
AND pt.UNIQUEFIELD IN (SELECT Distinct protocol from ctsi_webcamp_pr.opvisit WHERE VISITDATE between str_to_date('07,01,2022','%m,%d,%Y') and str_to_date('06,30,2023','%m,%d,%Y')
						UNION ALL
                       SELECT Distinct protocol from ctsi_webcamp_pr.admissio WHERE ADMITDATE between str_to_date('07,01,2022','%m,%d,%Y') and str_to_date('06,30,2023','%m,%d,%Y')
                        UNION ALL
                       SELECT Distinct protocol from ctsi_webcamp_pr.sbadmissio WHERE ADMITDATE between str_to_date('07,01,2022','%m,%d,%Y') and str_to_date('06,30,2023','%m,%d,%Y')
                       );
                        

;    
  


