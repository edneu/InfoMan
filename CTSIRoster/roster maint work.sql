

SELECT College,
       COUNT(Distinct Person_key) AS Undup from lookup.roster
WHERE College IS NOT NULL
  AND College NOT IN ('')
  AND FACULTY="Faculty"
GROUP BY COLLEGE  ;


SELECT Display_College,COUNT(*) 
from lookup.roster 
WHERE FACULTY="Faculty"group by Display_College;
;


SELECT Display_College,COUNT(DISTINCT Person_Key) 
from lookup.roster 
WHERE FACULTY="Faculty"
AND Affiliation="UF"
AND Display_College IS NOT NULL
group by Display_College;
;



drop table if exists work.colltemp;
create table work.colltemp as
Select College,Department, count(*) from lookup.roster
WHERE Display_College IS NULL or Display_College=""
AND Affiliation="UF"
GROUP BY College,Department;

UPDATE lookup.roster SET Affiliation="UCF" WHERE Department="UCF Department of Psychology";


SELECT * From Work.colltemp;

ALter table work.colltemp ADD Display_College varchar(255);


select * from lookup.college where 

UPDATE work.colltemp ct, lookup.college lu
SET ct.Display_College=lu.Standard_College
WHERE ct.College=lu.Lookup_COLLEGE


desc lookup.dept_coll;

UPDATE lookup.roster SET Display_College="Medicine - Jacksonville" Where Display_College="Medicine Jacksonville";





UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-ENTOMOLOGY AND NEMATOLOGY';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-FAM  YOUTH / COMM SCI';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-FAM  YOUTH / COMM SCI';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-FAMILY NUTRITION PROGRAM';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-FOOD SCIENCE / HUMAN NUTR';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-MICROBIOLOGY / CELL SCI';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-SCHL-FOREST RES / CONSERV';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-SWINE UNIT';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-ADVERSTISING-GENERAL';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-ADVERTISING';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-FELLOWSHIPS';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-GRADUATE DIVISION';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-GRADUATE STUDIES / RESEARC';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-PUBLIC RELATIONS';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-STEM TRANSLATIONAL COMMN';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE Department='CJC-TELECOMMUNICATIONS';
UPDATE lookup.roster SET Display_College='Arts' WHERE Department='COTA-BANDS';
UPDATE lookup.roster SET Display_College='Arts' WHERE Department='COTA-UNIVERSITY GALLERY';
UPDATE lookup.roster SET Display_College='Design, Construction and Planning' WHERE Department='DCP-INTERIOR DESIGN';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-COMMUNITY DENTISTRY';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-DCRU';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ENDODONTICS ADMIN';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-OPERATIVE DIVISION';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-OPERATIVE GENERAL DEPT';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORAL BIOLOGY';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORAL DIAGNOSTIC SCI ADMIN';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORAL MEDICINE';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORAL PATHOLOGY';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORAL SURGERY';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORAL SURGERY ADMIN';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORAL SURGERY RESIDENT';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORTHODONTICS RESEARCH';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-PROSTHODONTICS DIVISION';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE Department='DN-SFCC';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='DSO-SHANDS';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='DSO-SHANDS JAX CLINICAL PRACT';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='DSO-SHANDS UF';
UPDATE lookup.roster SET Display_College='Education' WHERE Department='DW-DIGITAL WORLD';
UPDATE lookup.roster SET Display_College='Education' WHERE Department='ED-CTR EXCEL EARLY CHILD STUD';
UPDATE lookup.roster SET Display_College='Education' WHERE Department='ED-GRAD STUDIES / TECHNOLOGY';
UPDATE lookup.roster SET Display_College='Education' WHERE Department='ED-SHDOSE-SCHL OF HUM DEV&ORG';
UPDATE lookup.roster SET Display_College='Education' WHERE Department='ED-SPED SPECIAL EDUCATION';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-BIOMEDICAL ENGINEERING';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-CHEMICAL ENGINEERING';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-COMPUTER / INFO SCI & ENG';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-ELECTRICAL / COMPUTER ENG';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-ENG SCH SUSTAIN INFRST ENV';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-INDUSTRIAL / SYSTEMS';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-INDUSTRIAL / SYSTEMS ENG';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-MATERIALS SCI ENGINEERING';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-MATERIALS SCIENCE';
UPDATE lookup.roster SET Display_College='Engineering' WHERE Department='EG-MECHANICAL / AEROSPACE ENG';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='EHS-ENVR / HLTH / SAFETY-ADMIN';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='EM-ENROLLMENT MANAGEMENT ADMIN';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='EM-FWS-COMMUNITY SERVICE';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='FLORIDA PROTON INSTITUTE SECUR';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='GR-GRAD SCHOOL OPERATIONS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='HA-EXECUTIVE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='HA-HSC NEWS / COMMUNICATIONS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='HA-INTEGRATED DATA REPOSITORY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='HA-IT TRAINING';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='Health Quality Institute';
UPDATE lookup.roster SET Display_College='Health and Human Performance' WHERE Department='HH-APK-ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Health and Human Performance' WHERE Department='HH-APPLIED PHYSIO/KINESIOLOGY';
UPDATE lookup.roster SET Display_College='Health and Human Performance' WHERE Department='HH-HEB-ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='HO-BROWARD / RAWLINGS AREA';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='HO-GRAHAM / HUME AREA';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='HO-HOUSING OFFICE';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='HO-LAKESIDE';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-CLINICAL / HLTH PSYCHOLOGY';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-ENVIRONMENTAL GLOBAL HLTH';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-HEALTH SERVICES ADMIN';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-OCCUPATIONAL THERAPY';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-OFFICE OF THE DEAN';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-PHYSICAL THERAPY';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-REHAB SCI DOCTORAL PROGRAM';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='HP-SLP LANG & HEARING SCI';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='HR-EMPLOYEE RELATIONS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='INSTITUTE-CHILD HEALTH POLICY';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='IT-PMO PROJECT MANAGEMENT OFF';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-ANESTHESIOLOGY-JAX';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-DEAN-ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-EMERGENCY MEDICINE-JAX';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-MEDICINE AT JAX';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-NEUROLOGY-JACKSONVILLE';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-OPHTHALMOLOGY-JAX';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-ORAL AND MAXILLOFACIAL SRGY';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-PATHOLOGY-JACKSONVILLE';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-PEDIATRICS-JACKSONVILLE';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-SURGERY-JACKSONVILLE';
UPDATE lookup.roster SET Display_College='Library' WHERE Department LIKE 'LB-DIRECTOR%S OFFICE-ADMIN';
UPDATE lookup.roster SET Display_College='Library' WHERE Department='LB-HSC - GENERAL';
UPDATE lookup.roster SET Display_College='Library' WHERE Department='LB-MARSTON SCI LIB CHAIR';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-BEBR SURVEY ADMIN';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-BIOLOGY';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-CHEMISTRY-GENERAL';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-DIAL CENTER';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-DIAL CENTER-GENERAL';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-LINGUISTICS';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-PSYCHOLOGY';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-PSYCHOLOGY-GENERAL';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-SOC/CRIM&LAW -GENERAL';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-STATISTICS';
UPDATE lookup.roster SET Display_College='Law' WHERE Department='LW-DEANS STRATEGIC INITIATIVES';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD - UF AHEC PROGRAM OFFICE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD - VASCULAR NEUROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-AGING / GERIATRIC RESEARCH';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-AGING-CLINICAL RESEARCH';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-AGING/ GERIATRIC RES-OTHER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ANACLERIO LEARNING CENTER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ANATOMY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ANEST CRITICAL CARE MED';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ANEST-ACUTE PAIN SERVICE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ANEST-CHRONIC PAIN MED';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ANEST-GEN EDUCATION OFFICE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ANESTHESIOLOGY-GENERAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-BEHAVIORAL NEUROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-BIOCHEM / MOLECULAR BIOL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-BIOCHEMISTRY-GENERAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-BIOETHICS  LAW / MEDICINE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-BIOLOGY OF AGING';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CANCER CENTER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CANCER CTR CLINICAL TRIALS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CARDIOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CARDIOLOGY-RESEARCH';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CHFM-GEN ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CHFM-STUDENT HEALTH CARE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CHILD HEALTH RES INSTITUTE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-COGNITAL HRT CTR EXCELLENCE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI SVC CTR - IDR';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-CLINICAL RESEARCH CNTR';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-INFO MGMT';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-OPERATIONS HRFISCAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-SECIM';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-SRVC CNTR-CTS-IT';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-TL1 TRAINING PRGM';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-TRANSL WORKFORCE DEVT';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-DERMATOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ED AFFR-STUDENT AFFAIRS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-EMERGENCY MED-CLINICAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ENDOCRINOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-GASTROENTERLOGY-LIVER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-GASTROENTEROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-GENERAL SURGERY - ADMIN';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-GERIATRIC MEDICINE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-HEMATOLOGY/ONCOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-HOBI-BIOMED INFORMATICS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-HOBI-GENERAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-HOBI-ONEFLORIDA';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-HOSPITAL MEDICINE DIVISION';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-INFECTIOUS DISEASES';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-INTERNAL MEDICINE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-MED CENTRAL-HOUSESTAFF';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-MEDICAL EDUCATION';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-MEDICINE CHAIRMAN';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-MOLECULAR GENTCS / MICROBIO';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEPHROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEPHROLOGY-OTHER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEURO-MULTIPLE SCLEROSIS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEURO-NEUROCRITICAL CARE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROLOGICAL SURGERY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROLOGY-ADMIN/EDUC';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROLOGY-EPILEPSY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROLOGY-GENERAL SERVICES';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROLOGY-MOVEMENT DISORDER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROMUSCULAR NEUROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROSCIENCE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROSCIENCE-GENERAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-OBSTETRICS / GYNECOLOGY-GEN';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-OPHTHALMOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-ORTHOPAEDICS / REHAB';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-OTOLARYNGOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PATHOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PATHOLOGY-GENERAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDIATRICS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-CRITICAL CARE DIVISION';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-DIABETES';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-ENDOCRINOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-GASTROENTEROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-GENERAL';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-GENETICS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-HEMATOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-HOSPITALIST PROGRAM';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-ICS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-IMMUNOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-INFECTIOUS DISEASES';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-MEDICAL EDUCATION';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-NEONATOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-NEPHROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-NEUROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PHARMACOLOGY / THERAPEUTICS';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PHYSIOLOGY FUNCTIONAL GENOM';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-POWELL GENE THERAPY CENTER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PSYCHIATRY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PULMONARY MEDICINE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PULMONARY-OTHER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PULMONARY-TRANSPLANT';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-RAD ONCOLOGY RADIOBIOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-RADIATION ONCOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-RADIOLGY-BODY IMAGING';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-RADIOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-RHEUMATOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY RESEARCH';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-BURN/WOUND CLINIC';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-CHAIRMAN';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-GEN-TRANSPLANT';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-PEDIATRIC';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-PLASTIC';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-RESIDENCY PROGRAM';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-SURGICAL ONCOLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-TCV';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-TRAUMA';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-VASCULAR';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-UFHCC NCI DESIGNATION';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-URO-PROSTATE DISEASE CENTER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-UROLOGY';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-UROLOGY-ADMIN';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='Neonat/Perinatology';
UPDATE lookup.roster SET Display_College='Natural History' WHERE Department='NH-INT SHARK OBSERVATORY';
UPDATE lookup.roster SET Display_College='Nursing' WHERE Department='NR-ASSOC DEAN FOR RES AFFRS';
UPDATE lookup.roster SET Display_College='Nursing' WHERE Department='NR-BNS-BIOBEHAVORIAL NUR SCI';
UPDATE lookup.roster SET Display_College='Nursing' WHERE Department='NR-DEAN-ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Nursing' WHERE Department='NR-EXECUTIVE ASO DEAN';
UPDATE lookup.roster SET Display_College='Nursing' WHERE Department='NR-FCH-FAMLY COMM HLTH SYS SCI';
UPDATE lookup.roster SET Display_College='Nursing' WHERE Department='NR-GRADUATE ENROLLMENT';
UPDATE lookup.roster SET Display_College='Nursing' WHERE Department='NR-OFFICE OF THE DEAN';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-CLINICAL RESEARCH';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-COMPLIANCE & GLOBAL SUPPORT';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-COMPUTING SERVICES DOR';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-EMERGING PATHOGENS';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-IACUC';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-INFORMATICS INSTITUTE';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-IRB-01 HEALTH CENTER';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-IRB-02 CAMPUS';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE Department='OR-RESEARCH OPERATIONS & SERVI';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='Pediatric Occupational Therapy';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='Pediatric Surgery';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department LIKE'Pediatrics%';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department LIKE 'PH-COP DEAN%S OFFICE';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-CURRICULARAFF&ACCREDITATION';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-DISTANCE CAMPUS ORLANDO';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-ENTPROGRAMS PHARM TRANS RES';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-MEDICINAL CHEMISTRY';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-OFFICE OF THE DEAN';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-OFFICE-EXPERIENTAL TRAIN';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-PHARM OUTCOMES & POLICY';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-PHARMACEUTICS';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-PHARMACODYNAMICS';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-PHARMTHERAPY TRNSL RSCH';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE Department='PH-SHARED SERVICE CENTER';
UPDATE lookup.roster SET Display_College='PHHP-COM BIOSTATISTICS' WHERE Department='PHHP-COM BIOSTATISTICS';
UPDATE lookup.roster SET Display_College='PHHP-COM EPIDEMIOLOGY' WHERE Department='PHHP-COM EPIDEMIOLOGY';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='PV-CNTR PRECOLLEGIATE EDUC';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='PV-CTR FOR UNDERGRAD RESEARCH';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='PV-UNDERGRADUATE STUDIES';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='REGISTRAR STUDENTS';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='RU-GAME ROOM ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='SA-RECREATIONAL SPORTS';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE Department='SH-EXECUTIVE STAFF';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='Surgery';
UPDATE lookup.roster SET Display_College='Veterinary Medicine' WHERE Department='VM-COMP, DIAG & POP MEDICINE';
UPDATE lookup.roster SET Display_College='Veterinary Medicine' WHERE Department='VM-INFECT DISEASE & IMMUNOLOGY';
UPDATE lookup.roster SET Display_College='Veterinary Medicine' WHERE Department='VM-LACS';
UPDATE lookup.roster SET Display_College='Veterinary Medicine' WHERE Department='VM-PHY SCI';
UPDATE lookup.roster SET Display_College='Veterinary Medicine' WHERE Department='VM-SACS';



UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE College='AG-DEAN FOR EXTENSION';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE College='AG-DEAN FOR RESEARCH';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE College='AG-OFFICE-SENIOR VICE PRES';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE College='AG/NAT RES DEPARTMENTS';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE College='AG/NAT RES OFF CAMPUS CENTERS';
UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE College='AG/NAT RES ON CAMPUS CENTERS';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE College='Arts and Sciences';
UPDATE lookup.roster SET Display_College='Arts' WHERE College='COLLEGE OF THE ARTS';
UPDATE lookup.roster SET Display_College='Business Administration' WHERE College='COLLEGE-BUSINESS ADMINISTRATION';
UPDATE lookup.roster SET Display_College='Design, Construction and Planning' WHERE College='COLLEGE-DCP';
UPDATE lookup.roster SET Display_College='Dentistry' WHERE College='COLLEGE-DENTISTRY';
UPDATE lookup.roster SET Display_College='Education' WHERE College='COLLEGE-EDUCATION';
UPDATE lookup.roster SET Display_College='Engineering' WHERE College='COLLEGE-ENGINEERING';
UPDATE lookup.roster SET Display_College='Health and Human Performance' WHERE College='COLLEGE-HLTH/HUMAN PERFORMANCE';
UPDATE lookup.roster SET Display_College='Journalism and Communications' WHERE College='COLLEGE-JOURNALISM / COMMUNICA';
UPDATE lookup.roster SET Display_College='Liberal Arts and Sciences' WHERE College='COLLEGE-LIBERAL ARTS/SCIENCES';
UPDATE lookup.roster SET Display_College='Medicine' WHERE College='COLLEGE-MEDICINE';
UPDATE lookup.roster SET Display_College='Medicine - Jacksonville' WHERE College='COLLEGE-MEDICINE JACKSONVILLE';
UPDATE lookup.roster SET Display_College='Nursing' WHERE College='COLLEGE-NURSING';
UPDATE lookup.roster SET Display_College='Pharmacy' WHERE College='COLLEGE-PHARMACY';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE College='COLLEGE-PUBL HLTH / HLTH PROFS';
UPDATE lookup.roster SET Display_College='Veterinary Medicine' WHERE College='COLLEGE-VETERINARY MED';
UPDATE lookup.roster SET Display_College='FSU-Communication and Information' WHERE College='Communication and Information';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='DIVISION-CONTINUING EDUCATION';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='DSO-DIRECT SUPPORT ORG';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='DW-DIGITAL WORLD';
UPDATE lookup.roster SET Display_College='Education' WHERE College='Education';
UPDATE lookup.roster SET Display_College='Natural History' WHERE College='FLORIDA MUSEUM NATURAL HISTORY';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='GRADUATE SCHOOL';
UPDATE lookup.roster SET Display_College='Health and Human Performance' WHERE College='Human Sciences';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='INFORMATION TECHNOLOGY';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='INTERNATIONAL CENTER';
UPDATE lookup.roster SET Display_College='Medicine' WHERE College='Medicine';
UPDATE lookup.roster SET Display_College='Nursing' WHERE College='Nursing';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='OFFICE OF HEALTH AFFAIRS';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='OFFICE OF PROVOST';
UPDATE lookup.roster SET Display_College='Office of Research' WHERE College='OFFICE OF RESEARCH';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='OFFICE OF STUDENT AFFAIRS';
UPDATE lookup.roster SET Display_College='PHHP-COM Intergrated Programs' WHERE College='PHHP-COM INTEGRATED PROGRAMS';
UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='REGISTRAR STUDENTS';
UPDATE lookup.roster SET Display_College='FSU-Social Work' WHERE College='Social Work';
UPDATE lookup.roster SET Display_College='Type One Centers' WHERE College='TYPE ONE CENTERS';
UPDATE lookup.roster SET Display_College='Library' WHERE College='UNIVERSITY LIBRARIES';

UPDATE lookup.roster SET Display_College='Non-Academic' WHERE College='BOARD OF TRUSTEES';

UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-FAM  YOUTH / COMM SCI';
UPDATE lookup.roster SET Display_College='Public Health and Health Professions' WHERE Department='Clinical Health and Psychology';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-BIOETHICS  LAW / MEDICINE';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='MD-PHD PROGRAM';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='Neurology';
UPDATE lookup.roster SET Display_College='Medicine' WHERE Department='Neuroscience';

UPDATE lookup.roster SET Display_College='Agriculture and Life Sciences' WHERE Department LIKE 'AG-%';

UPDATE lookup.roster SET Display_College='Medicine' WHERE Department LIKE 'MD-BIO%';

UPDATE work.nodepttemp SET Display_College='Agriculture and Life Sciences' WHERE Department='AG-ENTOMOLOGY AND NEMATOLOGY';
UPDATE work.nodepttemp SET Display_College='Dentistry' WHERE Department='DN-COMMUNITY DENTISTRY';
UPDATE work.nodepttemp SET Display_College='Dentistry' WHERE Department='DN-CONTINUING EDUCATION';
UPDATE work.nodepttemp SET Display_College='Dentistry' WHERE Department='DN-UNDERGRADUATE ROTATIONS';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='DSO-SHANDS JACKSONVILLE (JAX)';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='DSO-SHANDS UF';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='DSO-SHANDS UF PHYSICIANS (UFP)';
UPDATE work.nodepttemp SET Display_College='Engineering' WHERE Department='EG-FISCAL / PERSONNEL';
UPDATE work.nodepttemp SET Display_College='Engineering' WHERE Department='EG-RESEARCH SERVICE CENTERS';
UPDATE work.nodepttemp SET Display_College='Public Health and Health Professions' WHERE Department='HP-OCCUPATIONAL THERAPY';
UPDATE work.nodepttemp SET Display_College='Public Health and Health Professions' WHERE Department='HP-SLP LANG & HEARING SCI';
UPDATE work.nodepttemp SET Display_College='Medicine - Jacksonville' WHERE Department='JX-COMMUNITY MEDICINE-JAX';
UPDATE work.nodepttemp SET Display_College='Liberal Arts and Sciences' WHERE Department='LS-DEANS OFFICE';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-AGING-CLINICAL RESEARCH';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-ANEST-GEN EDUCATION OFFICE';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-ANESTHESIOLOGY-GENERAL';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-CANCER CTR CLINICAL TRIALS';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-CARDIOLOGY';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-CARDIOLOGY-RESEARCH';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-CME';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-CTSI-SRVC CNTR-CTS-IT';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-EMERGENCY MED-CLINICAL';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-GASTROENTERLOGY-LIVER';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-HEMATOLOGY/ONCOLOGY';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-HOBI-BIOMED INFORMATICS';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-HOBI-ONEFLORIDA';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-HOSPITAL MEDICINE DIVISION';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-NEUROLOGICAL SURGERY';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-NEUROLOGY-ADMIN/EDUC';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-NEUROLOGY-MOVEMENT DISORDER';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-PEDS AT ORLANDO HEALTH';
UPDATE work.nodepttemp SET Display_College='Medicine' WHERE Department='MD-PEDS-GENERAL';
UPDATE work.nodepttemp SET Display_College='Nursing' WHERE Department='NR-DEAN-ADMINISTRATION';
UPDATE work.nodepttemp SET Display_College='Office of Research' WHERE Department='OR-ICBR-PROTEOMICS';
UPDATE work.nodepttemp SET Display_College='Pharmacy' WHERE Department='PH-PHARM OUTCOMES & POLICY';
UPDATE work.nodepttemp SET Display_College='Pharmacy' WHERE Department='PH-PHARMTHERAPY TRNSL RSCH';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='REGISTRAR STUDENTS';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='TT-CONFERENCES';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='TT-DAP-ADMINISTRATION';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='TT-PRINT BASED DISTANCE EDUCA';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='TT-TREEO PROGRAM';
UPDATE work.nodepttemp SET Display_College='Non-Academic' WHERE Department='UF HR TRAINING';
UPDATE work.nodepttemp SET Display_College='Veterinary Medicine' WHERE Department='VM-SACS';






drop table if exists work.colltemp;
create table work.colltemp as
Select College,Department, count(*) from lookup.roster
WHERE Display_College IS NULL or Display_College=""
AND Affiliation="UF"
GROUP BY College,Department;


drop table if exists work.nodepttemp;
create table work.nodepttemp as
Select DISTINCT UFID 
FROM lookup.roster
WHERE Display_College IS NULL or Display_College=""
AND Affiliation="UF";
;


ALTER TABLE work.nodepttemp ADD Department varchar(45),
							ADD Display_College varchar(255);
                            
                            
UPDATE  work.nodepttemp nd, lookup.Employees lu
SET nd.Department=lu.Department
WHERE nd.UFID=lu.Employee_ID;    


select distinct UF_DEPT_NM from lookup.ufids;

UPDATE  work.nodepttemp nd, lookup.ufids lu
SET nd.Department=lu.UF_DEPT_NM
WHERE nd.UFID=lu.UF_UFID
AND nd.Department IS NULL
AND lu.UF_DEPT<>' ';

DELETE FROM work.nodepttemp WHERE Department is Null;

Alter table work.nodepttemp add DepartmentID varchar(12);

UPDATE work.nodepttemp nd, lookup.ufids lu
SET nd.DepartmentID=lu.UF_DEPT
WHERE nd.UFID=lu.UF_UFID;

SELECT * FROM work.nodepttemp;


UPDATE lookup.roster ro, work.nodepttemp lu
SET ro.Department=lu.Department,
	ro.Display_College=lu.Display_College,
    ro.DepartmentID=lu.DepartmentID
WHERE ro.UFID=lu.UFID
AND (ro.Department='' or ro.Department is null);


select distinct Department from lookup.roster;


drop table if exists work.colltemp;
create table work.colltemp as
Select Year,College,Department, count(*) from lookup.roster
WHERE Display_College IS NULL or Display_College=""
AND Affiliation="UF"
GROUP BY Year,College,Department;


UPDATE lookup.roster SET College='' WHERE College is NULL;
UPDATE lookup.roster SET Department='' WHERE Department is NULL;   

SELECT  FacultyType,Count(Distinct Person_Key) from lookup.roster Group by FacultyType;   

SELECT FacType,Count(Distinct Person_Key) from lookup.roster Group by FacType;    

SELECT  Faculty,Count(Distinct Person_Key) from lookup.roster Group by Faculty;      



SELECT  FacultyType,
        FacType,
        Faculty,
        Title,
        Count(Distinct Person_Key) 
from lookup.roster 
group by FacultyType,FacType,Faculty,Title;     



SELECT  FacultyType,
        FacType,
        Faculty,
                Count(Distinct Person_Key) 
from lookup.roster 
group by FacultyType,FacType,Faculty;                  
                            
                            
Select Distinct Salary_Plan from lookup.Employees where Salary_Plan like "%Faculty%";            

select Year,count(distinct Person_Key) from lookup.roster where ORIG_PROGRAM="One Florida" group by Year;

select Year,count(distinct Person_Key) from lookup.roster where Std_PRogram="Implementation Science" group by Year;


drop table if exists work.temp;
create table work.temp as

select * from lookup.roster 
where Std_PRogram="One Florida";

select distinct STD_PROGRAM from lookup.roster;


Implementation Science

create table loaddata.rosterBU20200109B as select * from lookup.roster;

UPDATE lookup.roster Set STD_PROGRAM="Implementation Science" Where ORIG_PROGRAM="Implementation Science Program (ISP)";

UPDATE lookup.roster Set ORIG_PROGRAM="One Florida" WHERE STD_PROGRAM="One Florida" AND  ORIG_PROGRAM="Implementation Science Program";




                