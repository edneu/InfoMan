* Encoding: UTF-8.


**************************************************************.
**************************************************************.
**************************************************************.
********************* 2011 Survey.
**************************************************************.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2011_Final.sav'.


Compute SURVEY_YEAR=2011.
Compute CTSI_User=1.
Compute RAC=$sysmis.
Compute ACTIVITY_ClinicalCare=$sysmis.
Compute ACTIVITY_Teaching=$sysmis.
Compute ACTIVITY_Research=$sysmis.
Compute ACTIVITY_Administration=$sysmis.
Compute CommCTSI=$sysmis.
Compute HelpfulCTSI=$sysmis.
Compute ImportCTSI=$sysmis.
Compute ResponsiveCTSI=$sysmis.
Compute LikeMeCTSI=$sysmis.
Compute ClinicaResearch=$sysmis.
Compute LabResearch=$sysmis.
Compute DeviceResearch=$sysmis.
Compute SocialResearch=$sysmis.
Compute HealthServicesResearch=$sysmis.
Compute CommunityResearch=$sysmis.
Compute EverService=$sysmis.
Compute EverEducation=$sysmis.
Compute EasyWebsite=$sysmis.
Compute CTSIimprovesAbility=$sysmis.
Compute CTSIImproveCollab=$sysmis.
Compute ClinicInfluenceResearch=$sysmis.
Compute ResearchInfluenceClinic=$sysmis.

EXECUTE.


RENAME VARIABLES 
(Survey_ID
Respondent
Q34_111
Q34_2
Q34_3
Q34_4
Q34_5
Q34_6
Q34_7
Q34_8
Q34_9
Q34_1
Q34_11
Q34_12
Q34_13
Q34_14
Q34_15
Q34_16
Q2
Q6
Q15
Q18
=Survey_ID
Respondent
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
FamiliarUFCTSI
EverWebsite
EverWorkshop
CTSIBenefit).

EXECUTE.

FORMATS
Survey_ID (A10) /
Respondent (A13) /
SURVEY_YEAR (F8.0) /
CTSI_User (F8.0) /
Contracting (F8.0) /
IRB (F8.0) /
BMI (F8.0) /
BioStat (F8.0) /
Regulatory (F8.0) /
LabSupp (F8.0) /
CoordSupp (F8.0) /
RecruitPartic (F8.0) /
IDCollab (F8.0) /
IDExperts (F8.0) /
ObtainData (F8.0) /
DesignMeasure (F8.0) /
Budget (F8.0) /
RecritStaff (F8.0) /
CommPartner (F8.0) /
Space (F8.0) /
RAC (F8.0) /
FamiliarUFCTSI (F8.0) /
ACTIVITY_ClinicalCare (F8.0) /
ACTIVITY_Teaching (F8.0) /
ACTIVITY_Research (F8.0) /
ACTIVITY_Administration (F8.0) /
CommCTSI (F8.0) /
HelpfulCTSI (F8.0) /
ImportCTSI (F8.0) /
ResponsiveCTSI (F8.0) /
LikeMeCTSI (F8.0) /
ClinicaResearch (F8.0) /
LabResearch (F8.0) /
DeviceResearch (F8.0) /
SocialResearch (F8.0) /
HealthServicesResearch (F8.0) /
CommunityResearch (F8.0) /
EverWebsite (F8.0) /
EverWorkshop (F8.0) /
EverService (F8.0) /
EverEducation (F8.0) /
EasyWebsite (F8.0) /
CTSIimprovesAbility (F8.0) /
CTSIImproveCollab (F8.0) /
CTSIBenefit (F8.0) /
ClinicInfluenceResearch (F8.0) /
ResearchInfluenceClinic (F8.0) .

VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.





SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2011_Barriers.sav'
  /KEEP 
Survey_ID
Respondent
SURVEY_YEAR
CTSI_User
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
  /COMPRESSED.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2011_Barriers.sav'.

**************************************************************.
**************************************************************.
**************************************************************.
******************
Compute SURVEY_YEAR=2012.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2012_Final.sav'.

Compute SURVEY_YEAR=2012.
Compute CTSI_User=1.
Compute RAC=$sysmis.
Compute ACTIVITY_ClinicalCare=$sysmis.
Compute ACTIVITY_Teaching=$sysmis.
Compute ACTIVITY_Research=$sysmis.
Compute ACTIVITY_Administration=$sysmis.
Compute CommCTSI=$sysmis.
Compute HelpfulCTSI=$sysmis.
Compute ImportCTSI=$sysmis.
Compute ResponsiveCTSI=$sysmis.
Compute LikeMeCTSI=$sysmis.
Compute ClinicaResearch=$sysmis.
Compute LabResearch=$sysmis.
Compute DeviceResearch=$sysmis.
Compute SocialResearch=$sysmis.
Compute HealthServicesResearch=$sysmis.
Compute CommunityResearch=$sysmis.
Compute EverService=$sysmis.
Compute EverEducation=$sysmis.
Compute EasyWebsite=$sysmis.
Compute CTSIimprovesAbility=$sysmis.
Compute CTSIImproveCollab=$sysmis.
Compute ClinicInfluenceResearch=$sysmis.
Compute ResearchInfluenceClinic=$sysmis.
EXECUTE.


RENAME VARIABLES 
(Survey_ID
Respondent
Q34_1
Q34_2
Q34_3
Q34_4
Q34_5
Q34_6
Q34_7
Q34_8
Q34_9
Q34_10
Q34_11
Q34_12
Q34_13
Q34_14
Q34_15
Q34_16
Q2
Q6
Q15
Q18
=Survey_ID
Respondent
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
FamiliarUFCTSI
EverWebsite
EverWorkshop
CTSIBenefit
).

EXECUTE.

FORMATS
Survey_ID (A10) /
Respondent (A13) /
SURVEY_YEAR (F8.0) /
CTSI_User (F8.0) /
Contracting (F8.0) /
IRB (F8.0) /
BMI (F8.0) /
BioStat (F8.0) /
Regulatory (F8.0) /
LabSupp (F8.0) /
CoordSupp (F8.0) /
RecruitPartic (F8.0) /
IDCollab (F8.0) /
IDExperts (F8.0) /
ObtainData (F8.0) /
DesignMeasure (F8.0) /
Budget (F8.0) /
RecritStaff (F8.0) /
CommPartner (F8.0) /
Space (F8.0) /
RAC (F8.0) /
FamiliarUFCTSI (F8.0) /
ACTIVITY_ClinicalCare (F8.0) /
ACTIVITY_Teaching (F8.0) /
ACTIVITY_Research (F8.0) /
ACTIVITY_Administration (F8.0) /
CommCTSI (F8.0) /
HelpfulCTSI (F8.0) /
ImportCTSI (F8.0) /
ResponsiveCTSI (F8.0) /
LikeMeCTSI (F8.0) /
ClinicaResearch (F8.0) /
LabResearch (F8.0) /
DeviceResearch (F8.0) /
SocialResearch (F8.0) /
HealthServicesResearch (F8.0) /
CommunityResearch (F8.0) /
EverWebsite (F8.0) /
EverWorkshop (F8.0) /
EverService (F8.0) /
EverEducation (F8.0) /
EasyWebsite (F8.0) /
CTSIimprovesAbility (F8.0) /
CTSIImproveCollab (F8.0) /
CTSIBenefit (F8.0) /
ClinicInfluenceResearch (F8.0) /
ResearchInfluenceClinic (F8.0) .

VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.





SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2012_Barriers.sav'
  /KEEP 
Survey_ID
Respondent
SURVEY_YEAR
CTSI_User
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
  /COMPRESSED.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2012_Barriers.sav'.


**************************************************************.
**************************************************************.
**************************************************************.
********************* 2013 Survey.
**************************************************************.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2013_Final.sav'.

Compute SURVEY_YEAR=2013.
Compute CTSI_User=1.
Compute RAC=$sysmis.
Compute ACTIVITY_ClinicalCare=$sysmis.
Compute ACTIVITY_Teaching=$sysmis.
Compute ACTIVITY_Research=$sysmis.
Compute ACTIVITY_Administration=$sysmis.
Compute CommCTSI=$sysmis.
Compute HelpfulCTSI=$sysmis.
Compute ImportCTSI=$sysmis.
Compute ResponsiveCTSI=$sysmis.
Compute LikeMeCTSI=$sysmis.
Compute ClinicaResearch=$sysmis.
Compute LabResearch=$sysmis.
Compute DeviceResearch=$sysmis.
Compute SocialResearch=$sysmis.
Compute HealthServicesResearch=$sysmis.
Compute CommunityResearch=$sysmis.
Compute EverService=$sysmis.
Compute EverEducation=$sysmis.
Compute EasyWebsite=$sysmis.
Compute CTSIimprovesAbility=$sysmis.
Compute CTSIImproveCollab=$sysmis.
Compute ClinicInfluenceResearch=$sysmis.
Compute ResearchInfluenceClinic=$sysmis.




RENAME VARIABLES (Survey_ID
Respondent
Q34_1
Q34_2
Q34_3
Q34_4
Q34_5
Q34_6
Q34_7
Q34_8
Q34_9
Q34_10
Q34_11
Q34_12
Q34_13
Q34_14
Q34_15
Q34_16
Q2
Q6
Q15
Q18
=Survey_ID
Respondent
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
FamiliarUFCTSI
EverWebsite
EverWorkshop
CTSIBenefit
) . 

EXECUTE.

FORMATS
Survey_ID (A10) /
Respondent (A13) /
SURVEY_YEAR (F8.0) /
CTSI_User (F8.0) /
Contracting (F8.0) /
IRB (F8.0) /
BMI (F8.0) /
BioStat (F8.0) /
Regulatory (F8.0) /
LabSupp (F8.0) /
CoordSupp (F8.0) /
RecruitPartic (F8.0) /
IDCollab (F8.0) /
IDExperts (F8.0) /
ObtainData (F8.0) /
DesignMeasure (F8.0) /
Budget (F8.0) /
RecritStaff (F8.0) /
CommPartner (F8.0) /
Space (F8.0) /
RAC (F8.0) /
FamiliarUFCTSI (F8.0) /
ACTIVITY_ClinicalCare (F8.0) /
ACTIVITY_Teaching (F8.0) /
ACTIVITY_Research (F8.0) /
ACTIVITY_Administration (F8.0) /
CommCTSI (F8.0) /
HelpfulCTSI (F8.0) /
ImportCTSI (F8.0) /
ResponsiveCTSI (F8.0) /
LikeMeCTSI (F8.0) /
ClinicaResearch (F8.0) /
LabResearch (F8.0) /
DeviceResearch (F8.0) /
SocialResearch (F8.0) /
HealthServicesResearch (F8.0) /
CommunityResearch (F8.0) /
EverWebsite (F8.0) /
EverWorkshop (F8.0) /
EverService (F8.0) /
EverEducation (F8.0) /
EasyWebsite (F8.0) /
CTSIimprovesAbility (F8.0) /
CTSIImproveCollab (F8.0) /
CTSIBenefit (F8.0) /
ClinicInfluenceResearch (F8.0) /
ResearchInfluenceClinic (F8.0) .



VARIABLE LABELS Survey_ID 'Survey_ID'.
VARIABLE LABELS Respondent 'Respondent'.
VARIABLE LABELS SURVEY_YEAR 'Year of Survey'.
VARIABLE LABELS CTSI_User 'CTSI User Flag'.
VARIABLE LABELS Contracting 'Contracting processes'.
VARIABLE LABELS IRB 'IRB submission and review'.
VARIABLE LABELS BMI 'Availability of biomedical informatics services'.
VARIABLE LABELS BioStat 'Availability of biostatistical support services'.
VARIABLE LABELS Regulatory 'Availability of ethics or regulatory support services'.
VARIABLE LABELS LabSupp 'Availability of laboratory support services'.
VARIABLE LABELS CoordSupp 'Availability of Research Coordinator Support'.
VARIABLE LABELS RecruitPartic 'Recruitment of research participants'.
VARIABLE LABELS IDCollab 'Identifying collaborators'.
VARIABLE LABELS IDExperts 'Identifying relevant experts'.
VARIABLE LABELS ObtainData 'Obtaining or sharing data'.
VARIABLE LABELS DesignMeasure 'Designing measures or instruments'.
VARIABLE LABELS Budget 'Preparing a project budget for a grant application'.
VARIABLE LABELS RecritStaff 'Recruiting and screening research project staff'.
VARIABLE LABELS CommPartner 'Identifying community-based research partners'.
VARIABLE LABELS Space 'Space to conduct research'.
VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.


SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2013_Barriers.sav'
  /KEEP 
Survey_ID
Respondent
SURVEY_YEAR
CTSI_User
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
  /COMPRESSED.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2013_Barriers.sav'.
**************************************************************.
**************************************************************.
**************************************************************.
********************* 2014 Survey.
**************************************************************.



GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2014_Final.sav'.

Compute SURVEY_YEAR=2014.
Compute Regulatory=$sysmis.
Compute LabSupp=$sysmis.
Compute IDCollab=$sysmis.
Compute ObtainData=$sysmis.
Compute DesignMeasure=$sysmis.
Compute RecritStaff=$sysmis.
Compute CommPartner=$sysmis.
Compute EverEducation=$sysmis.
EXECUTE.



RENAME VARIABLES (
Survey_ID
Respondent
CTSI_USER
Q13_3
Q13_2
Q15_3
Q14_4
Q14_2
Q13_5
Q15_4
Q15_2
Q14_3
Q13_6
Q2
Q6_1
Q6_2
Q6_3
Q6_4
Q40_1
Q40_2
Q40_3
Q40_5
Q40_7
Q7_1
Q7_2
Q7_3
Q7_4
Q7_5
Q7_6
Q4_1
Q4_2
Q4_3
Q22
Q23
Q24
Q25
Q8
Q9
=Survey_ID
Respondent
CTSI_User
Contracting
IRB
BMI
BioStat
CoordSupp
RecruitPartic
IDExperts
Budget
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
) . 

EXECUTE.

FORMATS
Survey_ID (A10) /
Respondent (A13) /
SURVEY_YEAR (F8.0) /
CTSI_User (F8.0) /
Contracting (F8.0) /
IRB (F8.0) /
BMI (F8.0) /
BioStat (F8.0) /
Regulatory (F8.0) /
LabSupp (F8.0) /
CoordSupp (F8.0) /
RecruitPartic (F8.0) /
IDCollab (F8.0) /
IDExperts (F8.0) /
ObtainData (F8.0) /
DesignMeasure (F8.0) /
Budget (F8.0) /
RecritStaff (F8.0) /
CommPartner (F8.0) /
Space (F8.0) /
RAC (F8.0) /
FamiliarUFCTSI (F8.0) /
ACTIVITY_ClinicalCare (F8.0) /
ACTIVITY_Teaching (F8.0) /
ACTIVITY_Research (F8.0) /
ACTIVITY_Administration (F8.0) /
CommCTSI (F8.0) /
HelpfulCTSI (F8.0) /
ImportCTSI (F8.0) /
ResponsiveCTSI (F8.0) /
LikeMeCTSI (F8.0) /
ClinicaResearch (F8.0) /
LabResearch (F8.0) /
DeviceResearch (F8.0) /
SocialResearch (F8.0) /
HealthServicesResearch (F8.0) /
CommunityResearch (F8.0) /
EverWebsite (F8.0) /
EverWorkshop (F8.0) /
EverService (F8.0) /
EverEducation (F8.0) /
EasyWebsite (F8.0) /
CTSIimprovesAbility (F8.0) /
CTSIImproveCollab (F8.0) /
CTSIBenefit (F8.0) /
ClinicInfluenceResearch (F8.0) /
ResearchInfluenceClinic (F8.0) .



VARIABLE LABELS Survey_ID 'Survey_ID'.
VARIABLE LABELS Respondent 'Respondent'.
VARIABLE LABELS SURVEY_YEAR 'Year of Survey'.
VARIABLE LABELS CTSI_User 'CTSI User Flag'.
VARIABLE LABELS Contracting 'Contracting processes'.
VARIABLE LABELS IRB 'IRB submission and review'.
VARIABLE LABELS BMI 'Availability of biomedical informatics services'.
VARIABLE LABELS BioStat 'Availability of biostatistical support services'.
VARIABLE LABELS Regulatory 'Availability of ethics or regulatory support services'.
VARIABLE LABELS LabSupp 'Availability of laboratory support services'.
VARIABLE LABELS CoordSupp 'Availability of Research Coordinator Support'.
VARIABLE LABELS RecruitPartic 'Recruitment of research participants'.
VARIABLE LABELS IDCollab 'Identifying collaborators'.
VARIABLE LABELS IDExperts 'Identifying relevant experts'.
VARIABLE LABELS ObtainData 'Obtaining or sharing data'.
VARIABLE LABELS DesignMeasure 'Designing measures or instruments'.
VARIABLE LABELS Budget 'Preparing a project budget for a grant application'.
VARIABLE LABELS RecritStaff 'Recruiting and screening research project staff'.
VARIABLE LABELS CommPartner 'Identifying community-based research partners'.
VARIABLE LABELS Space 'Space to conduct research'.
VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.


SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2014_Barriers.sav'
  /KEEP 
Survey_ID
Respondent
SURVEY_YEAR
CTSI_User
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
  /COMPRESSED.




GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2014_Barriers.sav'.



**************************************************************.
**************************************************************.
**************************************************************.
********************* 2015 Survey.
**************************************************************.

GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2015_Final.sav'.

Compute SURVEY_YEAR=2015.
Compute Regulatory=$sysmis.
Compute LabSupp=$sysmis.
Compute IDCollab=$sysmis.
Compute ObtainData=$sysmis.
Compute DesignMeasure=$sysmis.
Compute RecritStaff=$sysmis.
Compute CommPartner=$sysmis.

COMPUTE CTSI_USER= num(CTSIUser,F8.0).
EXECUTE.





RENAME VARIABLES (Survey_ID
Respondent
CTSI_User
Q15_3
Q15_2
Q17_3
Q16_4
Q16_2
Q15_5
Q17_4
Q17_2
Q16_3
Q15_6
Q3
Q8_1
Q8_2
Q8_3
Q8_4
Q42_1
Q42_2
Q42_3
Q42_5
Q42_7
Q9_1
Q9_2
Q9_3
Q9_4
Q9_5
Q9_6
Q5_1
Q5_2
Q5_3
Q5_4
Q31
Q32
Q33
Q34
Q10
Q11
=Survey_ID
Respondent
CTSI_User
Contracting
IRB
BMI
BioStat
CoordSupp
RecruitPartic
IDExperts
Budget
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
) . 


EXECUTE.

FORMATS
Survey_ID (A10) /
Respondent (A13) /
SURVEY_YEAR (F8.0) /
CTSI_User (F8.0) /
Contracting (F8.0) /
IRB (F8.0) /
BMI (F8.0) /
BioStat (F8.0) /
Regulatory (F8.0) /
LabSupp (F8.0) /
CoordSupp (F8.0) /
RecruitPartic (F8.0) /
IDCollab (F8.0) /
IDExperts (F8.0) /
ObtainData (F8.0) /
DesignMeasure (F8.0) /
Budget (F8.0) /
RecritStaff (F8.0) /
CommPartner (F8.0) /
Space (F8.0) /
RAC (F8.0) /
FamiliarUFCTSI (F8.0) /
ACTIVITY_ClinicalCare (F8.0) /
ACTIVITY_Teaching (F8.0) /
ACTIVITY_Research (F8.0) /
ACTIVITY_Administration (F8.0) /
CommCTSI (F8.0) /
HelpfulCTSI (F8.0) /
ImportCTSI (F8.0) /
ResponsiveCTSI (F8.0) /
LikeMeCTSI (F8.0) /
ClinicaResearch (F8.0) /
LabResearch (F8.0) /
DeviceResearch (F8.0) /
SocialResearch (F8.0) /
HealthServicesResearch (F8.0) /
CommunityResearch (F8.0) /
EverWebsite (F8.0) /
EverWorkshop (F8.0) /
EverService (F8.0) /
EverEducation (F8.0) /
EasyWebsite (F8.0) /
CTSIimprovesAbility (F8.0) /
CTSIImproveCollab (F8.0) /
CTSIBenefit (F8.0) /
ClinicInfluenceResearch (F8.0) /
ResearchInfluenceClinic (F8.0) .



VARIABLE LABELS Survey_ID 'Survey_ID'.
VARIABLE LABELS Respondent 'Respondent'.
VARIABLE LABELS SURVEY_YEAR 'Year of Survey'.
VARIABLE LABELS CTSI_User 'CTSI User Flag'.
VARIABLE LABELS Contracting 'Contracting processes'.
VARIABLE LABELS IRB 'IRB submission and review'.
VARIABLE LABELS BMI 'Availability of biomedical informatics services'.
VARIABLE LABELS BioStat 'Availability of biostatistical support services'.
VARIABLE LABELS Regulatory 'Availability of ethics or regulatory support services'.
VARIABLE LABELS LabSupp 'Availability of laboratory support services'.
VARIABLE LABELS CoordSupp 'Availability of Research Coordinator Support'.
VARIABLE LABELS RecruitPartic 'Recruitment of research participants'.
VARIABLE LABELS IDCollab 'Identifying collaborators'.
VARIABLE LABELS IDExperts 'Identifying relevant experts'.
VARIABLE LABELS ObtainData 'Obtaining or sharing data'.
VARIABLE LABELS DesignMeasure 'Designing measures or instruments'.
VARIABLE LABELS Budget 'Preparing a project budget for a grant application'.
VARIABLE LABELS RecritStaff 'Recruiting and screening research project staff'.
VARIABLE LABELS CommPartner 'Identifying community-based research partners'.
VARIABLE LABELS Space 'Space to conduct research'.
VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.


SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2015_Barriers.sav'
  /KEEP 
Survey_ID
Respondent
SURVEY_YEAR
CTSI_User
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
  /COMPRESSED.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2015_Barriers.sav'.


**************************************************************.
**************************************************************.
**************************************************************.
********************* 2016 Survey.
**************************************************************.

GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2016_Final.sav'.

Compute SURVEY_YEAR=2016.
Compute Regulatory=$sysmis.
Compute LabSupp=$sysmis.
Compute IDCollab=$sysmis.
Compute ObtainData=$sysmis.
Compute DesignMeasure=$sysmis.
Compute RecritStaff=$sysmis.
Compute CommPartner=$sysmis.
Compute ClinicInfluenceResearch=$sysmis.

COMPUTE CTSI_USER= num(CTSIUser,F8.0).
EXECUTE.



RENAME VARIABLES (Survey_ID
Respondent
CTSI_User
Q15_3
Q15_2
Q17_3
Q16_4
Q16_2
Q15_5
Q17_4
Q17_2
Q16_3
Q15_6
Q3
Q8_1
Q8_2
Q8_3
Q8_4
Q42_1
Q42_2
Q42_3
Q42_5
Q42_7
Q9_1
Q9_2
Q9_3
Q9_4
Q9_5
Q9_6
Q5_1
Q5_2
Q5_3
Q5_4
Q31
Q34
Q33
Q32
Q11
 =Survey_ID
Respondent
CTSI_User
Contracting
IRB
BMI
BioStat
CoordSupp
RecruitPartic
IDExperts
Budget
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ResearchInfluenceClinic
) . 


EXECUTE.

FORMATS
Survey_ID (A10) /
Respondent (A13) /
SURVEY_YEAR (F8.0) /
CTSI_User (F8.0) /
Contracting (F8.0) /
IRB (F8.0) /
BMI (F8.0) /
BioStat (F8.0) /
Regulatory (F8.0) /
LabSupp (F8.0) /
CoordSupp (F8.0) /
RecruitPartic (F8.0) /
IDCollab (F8.0) /
IDExperts (F8.0) /
ObtainData (F8.0) /
DesignMeasure (F8.0) /
Budget (F8.0) /
RecritStaff (F8.0) /
CommPartner (F8.0) /
Space (F8.0) /
RAC (F8.0) /
FamiliarUFCTSI (F8.0) /
ACTIVITY_ClinicalCare (F8.0) /
ACTIVITY_Teaching (F8.0) /
ACTIVITY_Research (F8.0) /
ACTIVITY_Administration (F8.0) /
CommCTSI (F8.0) /
HelpfulCTSI (F8.0) /
ImportCTSI (F8.0) /
ResponsiveCTSI (F8.0) /
LikeMeCTSI (F8.0) /
ClinicaResearch (F8.0) /
LabResearch (F8.0) /
DeviceResearch (F8.0) /
SocialResearch (F8.0) /
HealthServicesResearch (F8.0) /
CommunityResearch (F8.0) /
EverWebsite (F8.0) /
EverWorkshop (F8.0) /
EverService (F8.0) /
EverEducation (F8.0) /
EasyWebsite (F8.0) /
CTSIimprovesAbility (F8.0) /
CTSIImproveCollab (F8.0) /
CTSIBenefit (F8.0) /
ClinicInfluenceResearch (F8.0) /
ResearchInfluenceClinic (F8.0) .



VARIABLE LABELS Survey_ID 'Survey_ID'.
VARIABLE LABELS Respondent 'Respondent'.
VARIABLE LABELS SURVEY_YEAR 'Year of Survey'.
VARIABLE LABELS CTSI_User 'CTSI User Flag'.
VARIABLE LABELS Contracting 'Contracting processes'.
VARIABLE LABELS IRB 'IRB submission and review'.
VARIABLE LABELS BMI 'Availability of biomedical informatics services'.
VARIABLE LABELS BioStat 'Availability of biostatistical support services'.
VARIABLE LABELS Regulatory 'Availability of ethics or regulatory support services'.
VARIABLE LABELS LabSupp 'Availability of laboratory support services'.
VARIABLE LABELS CoordSupp 'Availability of Research Coordinator Support'.
VARIABLE LABELS RecruitPartic 'Recruitment of research participants'.
VARIABLE LABELS IDCollab 'Identifying collaborators'.
VARIABLE LABELS IDExperts 'Identifying relevant experts'.
VARIABLE LABELS ObtainData 'Obtaining or sharing data'.
VARIABLE LABELS DesignMeasure 'Designing measures or instruments'.
VARIABLE LABELS Budget 'Preparing a project budget for a grant application'.
VARIABLE LABELS RecritStaff 'Recruiting and screening research project staff'.
VARIABLE LABELS CommPartner 'Identifying community-based research partners'.
VARIABLE LABELS Space 'Space to conduct research'.
VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.


SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2016_Barriers.sav'
  /KEEP 
Survey_ID
Respondent
SURVEY_YEAR
CTSI_User
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
  /COMPRESSED.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2016_Barriers.sav'.

**************************************************************.
**************************************************************.
**************************************************************.
********************* 2017 Survey.
**************************************************************.

GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\CTSI_2017_Final.sav'.

Compute SURVEY_YEAR=2017.
EXECUTE.



Compute Regulatory=$sysmis.
Compute LabSupp=$sysmis.
Compute IDCollab=$sysmis.
Compute ObtainData=$sysmis.
Compute DesignMeasure=$sysmis.
Compute RecritStaff=$sysmis.
Compute CommPartner=$sysmis.
Compute EverService=$sysmis.
Compute ClinicInfluenceResearch=$sysmis.

COMPUTE CTSI_USER= num(CTSIUser,F8.0).
EXECUTE.


RENAME VARIABLES (
Q15_3
Q15_2
Q17_3
Q16_4
Q16_2
Q15_5
Q17_4
Q17_2
Q16_3
Q15_6
Q3
Q8_1
Q8_2
Q8_3
Q8_4
Q42_1
Q42_2
Q42_3
Q42_5
Q42_7
Q9_1
Q9_2
Q9_3
Q9_4
Q9_5
Q9_6
Q5_1
Q5_2
Q5_4
Q31
Q68
Q33
Q34
Q11
=Contracting
IRB
BMI
BioStat
CoordSupp
RecruitPartic
IDExperts
Budget
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ResearchInfluenceClinic) . 





EXECUTE.

FORMATS
Survey_ID (A10) /
Respondent (A13) /
SURVEY_YEAR (F8.0) /
CTSI_User (F8.0) /
Contracting (F8.0) /
IRB (F8.0) /
BMI (F8.0) /
BioStat (F8.0) /
Regulatory (F8.0) /
LabSupp (F8.0) /
CoordSupp (F8.0) /
RecruitPartic (F8.0) /
IDCollab (F8.0) /
IDExperts (F8.0) /
ObtainData (F8.0) /
DesignMeasure (F8.0) /
Budget (F8.0) /
RecritStaff (F8.0) /
CommPartner (F8.0) /
Space (F8.0) /
RAC (F8.0) /
FamiliarUFCTSI (F8.0) /
ACTIVITY_ClinicalCare (F8.0) /
ACTIVITY_Teaching (F8.0) /
ACTIVITY_Research (F8.0) /
ACTIVITY_Administration (F8.0) /
CommCTSI (F8.0) /
HelpfulCTSI (F8.0) /
ImportCTSI (F8.0) /
ResponsiveCTSI (F8.0) /
LikeMeCTSI (F8.0) /
ClinicaResearch (F8.0) /
LabResearch (F8.0) /
DeviceResearch (F8.0) /
SocialResearch (F8.0) /
HealthServicesResearch (F8.0) /
CommunityResearch (F8.0) /
EverWebsite (F8.0) /
EverWorkshop (F8.0) /
EverService (F8.0) /
EverEducation (F8.0) /
EasyWebsite (F8.0) /
CTSIimprovesAbility (F8.0) /
CTSIImproveCollab (F8.0) /
CTSIBenefit (F8.0) /
ClinicInfluenceResearch (F8.0) /
ResearchInfluenceClinic (F8.0) .



VARIABLE LABELS Survey_ID 'Survey_ID'.
VARIABLE LABELS Respondent 'Respondent'.
VARIABLE LABELS SURVEY_YEAR 'Year of Survey'.
VARIABLE LABELS CTSI_User 'CTSI User Flag'.
VARIABLE LABELS Contracting 'Contracting processes'.
VARIABLE LABELS IRB 'IRB submission and review'.
VARIABLE LABELS BMI 'Availability of biomedical informatics services'.
VARIABLE LABELS BioStat 'Availability of biostatistical support services'.
VARIABLE LABELS Regulatory 'Availability of ethics or regulatory support services'.
VARIABLE LABELS LabSupp 'Availability of laboratory support services'.
VARIABLE LABELS CoordSupp 'Availability of Research Coordinator Support'.
VARIABLE LABELS RecruitPartic 'Recruitment of research participants'.
VARIABLE LABELS IDCollab 'Identifying collaborators'.
VARIABLE LABELS IDExperts 'Identifying relevant experts'.
VARIABLE LABELS ObtainData 'Obtaining or sharing data'.
VARIABLE LABELS DesignMeasure 'Designing measures or instruments'.
VARIABLE LABELS Budget 'Preparing a project budget for a grant application'.
VARIABLE LABELS RecritStaff 'Recruiting and screening research project staff'.
VARIABLE LABELS CommPartner 'Identifying community-based research partners'.
VARIABLE LABELS Space 'Space to conduct research'.
VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.


SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2017_Barriers.sav'
  /KEEP 
Survey_ID
Respondent
SURVEY_YEAR
CTSI_User
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
FamiliarUFCTSI
ACTIVITY_ClinicalCare
ACTIVITY_Teaching
ACTIVITY_Research
ACTIVITY_Administration
CommCTSI
HelpfulCTSI
ImportCTSI
ResponsiveCTSI
LikeMeCTSI
ClinicaResearch
LabResearch
DeviceResearch
SocialResearch
HealthServicesResearch
CommunityResearch
EverWebsite
EverWorkshop
EverService
EverEducation
EasyWebsite
CTSIimprovesAbility
CTSIImproveCollab
CTSIBenefit
ClinicInfluenceResearch
ResearchInfluenceClinic
College
  /COMPRESSED.


GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2017_Barriers.sav'.

*****************************************************************************************************.

GET FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_Barriers.sav'.

SELECT IF SURVEY_YEAR<>2017.
EXECUTE.

SORT CASES by  Respondent .


MATCH FILES /FILE=*
  /TABLE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CollegeLookup2.sav'
  /BY Respondent.
EXECUTE.

ADD FILES /FILE=*
  /FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2017_Barriers.sav'.
EXECUTE.

****** Recode Colleges Standardize.
RECODE College ('COLLEGE- AGRICUL / NAT RES'='Agricul / Nat Res').
RECODE College ('COLLEGE OF THE ARTS'='Arts').
RECODE College ('COTA-Center For AIM'='Arts').
RECODE College ('COLLEGE-BUSINESS ADMINSTRATION'='Business Adminstration').
RECODE College ('COLLEGE-DENTISTRY'='Dentistry').
RECODE College ('COLLEGE-DESIGN CONSTRUC / PLAN'='Design and Construction').
RECODE College ('DIVISION-CONTINUING EDUCATION'='Division-Continuing Education').
RECODE College ('COLLEGE-EDUCATION'='Education').
RECODE College ('COLLEGE-ENGINEERING'='Engineering').
RECODE College ('GRADUATE SCHOOL'='Graduate School').
RECODE College ('Graduate School'='Graduate School').
RECODE College ('COLLEGE-HLTH/HUMAN PERFORMANCE'='Hlth/Human Performance').
RECODE College ('INFORMATION TECHNOLOGY'='Information Technology').
RECODE College ('INTERNATIONAL CENTER'='International Center').
RECODE College ('COLLEGE-JOURNALISM / COMMUNICA'='Journalism and Communication').
RECODE College ('COLLEGE-LAW'='Law').
RECODE College ('CLAS'='Liberal Arts/Sciences').
RECODE College ('COLLEGE-LIBERAL ARTS/SCIENCES'='Liberal Arts/Sciences').
RECODE College ('COLLEGE-MEDICINE'='Medicine').
RECODE College ('COLLEGE-MEDICINE JACKSONVILLE'='Medicine Jacksonville').
RECODE College ('COLLEGE-NURSING'='Nursing').
RECODE College ('OFFICE OF HEALTH AFFAIRS'='Office Of Health Affairs').
RECODE College ('OFFICE OF PROVOST'='Office Of Provost').
RECODE College ('OFFICE OF RESEARCH'='Office of Research').
RECODE College ('COLLEGE-PHARMACY'='Pharmacy').
RECODE College ('PHHP-COM INTEGRATED PROGRAMS'='PHHP-COM').
RECODE College ('COLLEGE-PUBL HLTH / HLTH PROFS'='Publ Hlth / Hlth Profs').
RECODE College ('RESEARCH / SPONSORED PROGRAMS'='Research / Sponsored Programs').
RECODE College ('UNIVERSITY LIBRARIES'='University Libraries').
RECODE College ('COLLEGE-VETERINARY MED'='Veterinary Med').

EXECUTE.















***************** OLD MERGE CODE FOLLOWS
**********************************************************************************************************.
*** APPEND ALL YEARS.
**********************************************************************************************************.
GET
  FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual '+
    'Surveys\AnnualSurveyData\Barriers Redux\CTSI_2011_Barriers.sav'.

SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_Barriers.sav'
   /COMPRESSED.

ADD FILES /FILE=*
  /FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2012_Barriers.sav'.
EXECUTE.


ADD FILES /FILE=*
  /FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2013_Barriers.sav'.
EXECUTE.


ADD FILES /FILE=*
  /FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2014_Barriers.sav'.
EXECUTE.


ADD FILES /FILE=*
  /FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2015_Barriers.sav'.
EXECUTE.


ADD FILES /FILE=*
  /FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2016_Barriers.sav'.
EXECUTE.

ADD FILES /FILE=*
  /FILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_2017_Barriers.sav'.
EXECUTE.

VARIABLE LABELS Survey_ID 'Survey_ID'.
VARIABLE LABELS Respondent 'Respondent'.
VARIABLE LABELS SURVEY_YEAR 'Year of Survey'.
VARIABLE LABELS CTSI_User 'CTSI User Flag'.
VARIABLE LABELS Contracting 'Contracting processes'.
VARIABLE LABELS IRB 'IRB submission and review'.
VARIABLE LABELS BMI 'Availability of biomedical informatics services'.
VARIABLE LABELS BioStat 'Availability of biostatistical support services'.
VARIABLE LABELS Regulatory 'Availability of ethics or regulatory support services'.
VARIABLE LABELS LabSupp 'Availability of laboratory support services'.
VARIABLE LABELS CoordSupp 'Availability of Research Coordinator Support'.
VARIABLE LABELS RecruitPartic 'Recruitment of research participants'.
VARIABLE LABELS IDCollab 'Identifying collaborators'.
VARIABLE LABELS IDExperts 'Identifying relevant experts'.
VARIABLE LABELS ObtainData 'Obtaining or sharing data'.
VARIABLE LABELS DesignMeasure 'Designing measures or instruments'.
VARIABLE LABELS Budget 'Preparing a project budget for a grant application'.
VARIABLE LABELS RecritStaff 'Recruiting and screening research project staff'.
VARIABLE LABELS CommPartner 'Identifying community-based research partners'.
VARIABLE LABELS Space 'Space to conduct research'.
VARIABLE LABELS RAC 'Research Administration and Compliance (RAC)'.
VARIABLE LABELS FamiliarUFCTSI 'Familiarity with the CTSI at UF'.
VARIABLE LABELS ACTIVITY_ClinicalCare 'Are you engaged in any of these university-related activities?-Clinical Practice / Care of Patients'.
VARIABLE LABELS ACTIVITY_Teaching 'Are you engaged in any of these university-related activities?-Teaching / Mentoring'.
VARIABLE LABELS ACTIVITY_Research 'Are you engaged in any of these university-related activities?-Research'.
VARIABLE LABELS ACTIVITY_Administration 'Are you engaged in any of these university-related activities?-Administration'.
VARIABLE LABELS CommCTSI 'It is easy to communicate with the CTSI'.
VARIABLE LABELS HelpfulCTSI 'The CTSI is very helpful.'.
VARIABLE LABELS ImportCTSI 'The CTSI plays an important role at the University.'.
VARIABLE LABELS ResponsiveCTSI 'The CTSI is responsive to my needs.'.
VARIABLE LABELS LikeMeCTSI 'The CTSI does not assist investigators like me.'.
VARIABLE LABELS ClinicaResearch 'Clinical or patient-oriented research'.
VARIABLE LABELS LabResearch 'Laboratory research (e.g., cells, tissues, materials)'.
VARIABLE LABELS DeviceResearch 'Research on devices or instruments'.
VARIABLE LABELS SocialResearch 'Social science / human behavior research'.
VARIABLE LABELS HealthServicesResearch 'Health services research'.
VARIABLE LABELS CommunityResearch 'Community-based research'.
VARIABLE LABELS EverWebsite 'Ever Visited the CTSI Website?'.
VARIABLE LABELS EverWorkshop 'Ever Attended a CTSI workshop or seminar?'.
VARIABLE LABELS EverService 'Ever Used a service offered by the CTSI?'.
VARIABLE LABELS EverEducation 'Ever Participated in a CTSI professional development or education program?'.
VARIABLE LABELS EasyWebsite 'How easy is it to navigate the CTSI Website?'.
VARIABLE LABELS CTSIimprovesAbility 'How much have CTSI services improved your ability to do research?'.
VARIABLE LABELS CTSIImproveCollab 'How much has the CTSI enhanced your research collaboration?'.
VARIABLE LABELS CTSIBenefit 'How much has your research benefited from CTSI services or programs?'.
VARIABLE LABELS ClinicInfluenceResearch 'How much has the medical practice of others influenced your research program?'.
VARIABLE LABELS ResearchInfluenceClinic 'How much have research results influenced your clinical practice?'.

RENAME VARIABLES (
Contracting
IRB
BMI
BioStat
Regulatory
LabSupp
CoordSupp
RecruitPartic
IDCollab
IDExperts
ObtainData
DesignMeasure
Budget
RecritStaff
CommPartner
Space
RAC
=Barrier_Contracting
Barrier_IRB
Barrier_BMI
Barrier_BioStat
Barrier_Regulatory
Barrier_LabSupp
Barrier_CoordSupp
Barrier_RecruitPartic
Barrier_IDCollab
Barrier_IDExperts
Barrier_ObtainData
Barrier_DesignMeasure
Barrier_Budget
Barrier_RecritStaff
Barrier_CommPartner
Barrier_Space
Barrier_RAC
) . 

*** CALCULATE SEVERE OR EXTREME INDICATORS SE.
Compute SE_Barrier_Contracting=$sysmis.
Compute SE_Barrier_IRB=$sysmis.
Compute SE_Barrier_BMI=$sysmis.
Compute SE_Barrier_BioStat=$sysmis.
Compute SE_Barrier_Regulatory=$sysmis.
Compute SE_Barrier_LabSupp=$sysmis.
Compute SE_Barrier_CoordSupp=$sysmis.
Compute SE_Barrier_RecruitPartic=$sysmis.
Compute SE_Barrier_IDCollab=$sysmis.
Compute SE_Barrier_IDExperts=$sysmis.
Compute SE_Barrier_ObtainData=$sysmis.
Compute SE_Barrier_DesignMeasure=$sysmis.
Compute SE_Barrier_Budget=$sysmis.
Compute SE_Barrier_RecritStaff=$sysmis.
Compute SE_Barrier_CommPartner=$sysmis.
Compute SE_Barrier_Space=$sysmis.
Compute SE_Barrier_RAC=$sysmis.
EXECUTE.

IF Barrier_Contracting>=4 SE_Barrier_Contracting=1.
IF Barrier_IRB>=4 SE_Barrier_IRB=1.
IF Barrier_BMI>=4 SE_Barrier_BMI=1.
IF Barrier_BioStat>=4 SE_Barrier_BioStat=1.
IF Barrier_Regulatory>=4 SE_Barrier_Regulatory=1.
IF Barrier_LabSupp>=4 SE_Barrier_LabSupp=1.
IF Barrier_CoordSupp>=4 SE_Barrier_CoordSupp=1.
IF Barrier_RecruitPartic>=4 SE_Barrier_RecruitPartic=1.
IF Barrier_IDCollab>=4 SE_Barrier_IDCollab=1.
IF Barrier_IDExperts>=4 SE_Barrier_IDExperts=1.
IF Barrier_ObtainData>=4 SE_Barrier_ObtainData=1.
IF Barrier_DesignMeasure>=4 SE_Barrier_DesignMeasure=1.
IF Barrier_Budget>=4 SE_Barrier_Budget=1.
IF Barrier_RecritStaff>=4 SE_Barrier_RecritStaff=1.
IF Barrier_CommPartner>=4 SE_Barrier_CommPartner=1.
IF Barrier_Space>=4 SE_Barrier_Space=1.
IF Barrier_RAC>=4 SE_Barrier_RAC=1.
EXECUTE.

IF Barrier_Contracting<4 SE_Barrier_Contracting=0.
IF Barrier_IRB<4 SE_Barrier_IRB=0.
IF Barrier_BMI<4 SE_Barrier_BMI=0.
IF Barrier_BioStat<4 SE_Barrier_BioStat=0.
IF Barrier_Regulatory<4 SE_Barrier_Regulatory=0.
IF Barrier_LabSupp<4 SE_Barrier_LabSupp=0.
IF Barrier_CoordSupp<4 SE_Barrier_CoordSupp=0.
IF Barrier_RecruitPartic<4 SE_Barrier_RecruitPartic=0.
IF Barrier_IDCollab<4 SE_Barrier_IDCollab=0.
IF Barrier_IDExperts<4 SE_Barrier_IDExperts=0.
IF Barrier_ObtainData<4 SE_Barrier_ObtainData=0.
IF Barrier_DesignMeasure<4 SE_Barrier_DesignMeasure=0.
IF Barrier_Budget<4 SE_Barrier_Budget=0.
IF Barrier_RecritStaff<4 SE_Barrier_RecritStaff=0.
IF Barrier_CommPartner<4 SE_Barrier_CommPartner=0.
IF Barrier_Space<4 SE_Barrier_Space=0.
IF Barrier_RAC<4 SE_Barrier_RAC=0.
EXECUTE.


VARIABLE LABELS SE_Barrier_Contracting 'Contracting processes'.
VARIABLE LABELS SE_Barrier_IRB 'IRB submission and review'.
VARIABLE LABELS SE_Barrier_BMI 'Availability of biomedical informatics services'.
VARIABLE LABELS SE_Barrier_BioStat 'Availability of biostatistical support services'.
VARIABLE LABELS SE_Barrier_Regulatory 'Availability of ethics or regulatory support services'.
VARIABLE LABELS SE_Barrier_LabSupp 'Availability of laboratory support services'.
VARIABLE LABELS SE_Barrier_CoordSupp 'Availability of Research Coordinator Support'.
VARIABLE LABELS SE_Barrier_RecruitPartic 'Recruitment of research participants'.
VARIABLE LABELS SE_Barrier_IDCollab 'Identifying collaborators'.
VARIABLE LABELS SE_Barrier_IDExperts 'Identifying relevant experts'.
VARIABLE LABELS SE_Barrier_ObtainData 'Obtaining or sharing data'.
VARIABLE LABELS SE_Barrier_DesignMeasure 'Designing measures or instruments'.
VARIABLE LABELS SE_Barrier_Budget 'Preparing a project budget for a grant application'.
VARIABLE LABELS SE_Barrier_RecritStaff 'Recruiting and screening research project staff'.
VARIABLE LABELS SE_Barrier_CommPartner 'Identifying community-based research partners'.
VARIABLE LABELS SE_Barrier_Space 'Space to conduct research'.
VARIABLE LABELS SE_Barrier_RAC 'Research Administration and Compliance (RAC)'.

RECODE CommCTSI HelpfulCTSI ImportCTSI ResponsiveCTSI LikeMeCTSI (12=1) (13=2) (14=3) (15=4) (16=5).    
EXECUTE.

RECODE CTSIimprovesAbility CTSIImproveCollab CTSIBenefit (6=1) (7=2) (8=3) (9=4) (10=5).
EXECUTE.

RECODE EasyWebsite (35=1) (36=2) (37=3) (38=4) (39=5).
EXECUTE.

RECODE ClinicInfluenceResearch (11=2).
EXECUTE.

SAVE OUTFILE='C:\Users\edneu\Dropbox (UFL)\CTSI Evaluation Committee\CTSI Surveys\CTSI Annual Surveys\AnnualSurveyData\Barriers Redux\CTSI_Barriers.sav'
   /COMPRESSED.

**********************************************************************************************************.
**********************************************************************************************************.
**********************************************************************************************************.
**********************************************************************************************************.
****************************************.
USE ALL.
COMPUTE filter_$=(CTSI_User=1).
VARIABLE LABELS filter_$ 'CTSI_User=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE

.******************************************************************.
*********** ANALYSIS   BARRIERS TABLE.


SUMMARIZE
  /TABLES=SE_Barrier_Contracting SE_Barrier_IRB SE_Barrier_BMI SE_Barrier_BioStat 
    SE_Barrier_Regulatory SE_Barrier_LabSupp SE_Barrier_CoordSupp SE_Barrier_RecruitPartic 
    SE_Barrier_IDCollab SE_Barrier_IDExperts SE_Barrier_ObtainData SE_Barrier_DesignMeasure 
    SE_Barrier_Budget SE_Barrier_RecritStaff SE_Barrier_CommPartner SE_Barrier_Space SE_Barrier_RAC BY 
    CTSI_User BY SURVEY_YEAR
  /FORMAT=NOLIST NOTOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=SUM COUNT.


RECODE CTSIimprovesAbility CTSIImproveCollab CTSIBenefit (6=1) (7=2) (8=3) (9=4) (10=5).
EXECUTE.



RECODE ClinicInfluenceResearch (11=2).
EXECUTE.


####################################################################################
###########  WEIGHTING TABLE
#####################################################################################




