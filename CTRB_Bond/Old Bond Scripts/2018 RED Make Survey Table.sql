/*
This SQL Creates the Table formatted for the Qualtrics Survey
It requires the work.survey_bondmaster table created in the Red Make BondMaster.SQL

The Program creates a series of Span files for populated spans (space.SurveyTable)

Note: Uses a 2 Segment Join for Performance
*/


##### find maximum number of spans adJust code below
# SELECT MAX(Span) FROM space.bondmaster;
#
# Create a Copy of the bondmaster table with only the needed records (modify where clause)
Drop table if exists work.survey_bondmaster;
Create Table work.survey_bondmaster AS
Select * from space.bondmaster;
## where CTRB_PCT_PREV>0;





#  Create Temporary Span Tables

Drop Table if Exists work.bondproj1;	
create table work.bondproj1 as
select * from work.survey_bondmaster where Span=1;

Drop Table if Exists work.Span2;
create table work.Span2 as
select * from work.survey_bondmaster where Span=2;

Drop Table if Exists work.Span3;
create table work.Span3 as
select * from work.survey_bondmaster where Span=3;

Drop Table if Exists work.Span4;
create table work.Span4 as
select * from work.survey_bondmaster where Span=4;

Drop Table if Exists work.Span5;
create table work.Span5 as
select * from work.survey_bondmaster where Span=5;

Drop Table if Exists work.Span6;
create table work.Span6 as
select * from work.survey_bondmaster where Span=6;

Drop Table if Exists work.Span7;
create table work.Span7 as
select * from work.survey_bondmaster where Span=7;

Drop Table if Exists work.Span8;
create table work.Span8 as
select * from work.survey_bondmaster where Span=8;

Drop Table if Exists work.Span9;
create table work.Span9 as
select * from work.survey_bondmaster where Span=9;

Drop Table if Exists work.Span10;
create table work.Span10 as
select * from work.survey_bondmaster where Span=10;

Drop Table if Exists work.Span11;
create table work.Span11 as
select * from work.survey_bondmaster where Span=11;

Drop Table if Exists work.Span12;
create table work.Span12 as
select * from work.survey_bondmaster where Span=12;

Drop Table if Exists work.Span13;
create table work.Span13 as
select * from work.survey_bondmaster where Span=13;

Drop Table if Exists work.Span14;
create table work.Span14 as
select * from work.survey_bondmaster where Span=14;

Drop Table if Exists work.Span15;
create table work.Span15 as
select * from work.survey_bondmaster where Span=15;

Drop Table if Exists work.Span16;
create table work.Span16 as
select * from work.survey_bondmaster where Span=16;

Drop Table if Exists work.Span17;
create table work.Span17 as
select * from work.survey_bondmaster where Span=17;

Drop Table if Exists work.Span18;
create table work.Span18 as
select * from work.survey_bondmaster where Span=18;

Drop Table if Exists work.Span19;
create table work.Span19 as
select * from work.survey_bondmaster where Span=19;

Drop Table if Exists work.Span20;
create table work.Span20 as
select * from work.survey_bondmaster where Span=20;

Drop Table if Exists work.Span21;
create table work.Span21 as
select * from work.survey_bondmaster where Span=21;

Drop Table if Exists work.Span22;
create table work.Span22 as
select * from work.survey_bondmaster where Span=22;

Drop Table if Exists work.Span23;
create table work.Span23 as
select * from work.survey_bondmaster where Span=23;

Drop Table if Exists work.Span24;
create table work.Span24 as
select * from work.survey_bondmaster where Span=24;

Drop Table if Exists work.Span25;
create table work.Span25 as
select * from work.survey_bondmaster where Span=25;






CREATE INDEX surveyUFID ON work.bondproj1 (AWARD_INV_UFID);
############################################################################SEGMENTED JOIN HERE
Drop Table if Exists work.SurveyTable1;
create table work.SurveyTable1 as
select bp.AWARD_INV_UFID,
       bp.LastName,
       bp.FirstName, 
       bp.email, 

       bp.AWARD_ID as Project1,
       bp.SponsorName as Agency1,
       bp.SponsorID as AgNo1,
       bp.Sponsor_Type as AgencyType1,
       bp.Title as Title1,

       s2.AWARD_ID as Project2,
       s2.SponsorName as Agency2,
       s2.SponsorID as AgNo2,
       s2.Sponsor_Type as AgencyType2, 
       s2.Title as Title2,

       s3.AWARD_ID as Project3,
       s3.SponsorName as Agency3,
       s3.SponsorID as AgNo3,
       s3.Sponsor_Type as AgencyType3, 
       s3.Title as Title3,

       s4.AWARD_ID as Project4,
       s4.SponsorName as Agency4,
       s4.SponsorID as AgNo4,
       s4.Sponsor_Type as AgencyType4, 
       s4.Title as Title4,

       s5.AWARD_ID as Project5,
       s5.SponsorName as Agency5,
       s5.SponsorID as AgNo5,
       s5.Sponsor_Type as AgencyType5, 
       s5.Title as Title5,

       s6.AWARD_ID as Project6,
       s6.SponsorName as Agency6,
       s6.SponsorID as AgNo6,
       s6.Sponsor_Type as AgencyType6, 
       s6.Title as Title6,

       s7.AWARD_ID as Project7,
       s7.SponsorName as Agency7,
       s7.SponsorID as AgNo7,
       s7.Sponsor_Type as AgencyType7, 
       s7.Title as Title7,

       s8.AWARD_ID as Project8,
       s8.SponsorName as Agency8,
       s8.SponsorID as AgNo8,
       s8.Sponsor_Type as AgencyType8, 
       s8.Title as Title8,

       s9.AWARD_ID as Project9,
       s9.SponsorName as Agency9,
       s9.SponsorID as AgNo9,
       s9.Sponsor_Type as AgencyType9, 
       s9.Title as Title9,

       s10.AWARD_ID as Project10,
       s10.SponsorName as Agency10,
       s10.SponsorID as AgNo10,
       s10.Sponsor_Type as AgencyType10, 
       s10.Title as Title10,

       s11.AWARD_ID as Project11,
       s11.SponsorName as Agency11,
       s11.SponsorID as AgNo11,
       s11.Sponsor_Type as AgencyType11, 
       s11.Title as Title11,

       s12.AWARD_ID as Project12,
       s12.SponsorName as Agency12,
       s12.SponsorID as AgNo12,
       s12.Sponsor_Type as AgencyType12, 
       s12.Title as Title12,

       s13.AWARD_ID as Project13,
       s13.SponsorName as Agency13,
       s13.SponsorID as AgNo13,
       s13.Sponsor_Type as AgencyType13, 
       s13.Title as Title13,

       s14.AWARD_ID as Project14,
       s14.SponsorName as Agency14,
       s14.SponsorID as AgNo14,
       s14.Sponsor_Type as AgencyType14, 
       s14.Title as Title14,

       s15.AWARD_ID as Project15,
       s15.SponsorName as Agency15,
       s15.SponsorID as AgNo15,
       s15.Sponsor_Type as AgencyType15, 
       s15.Title as Title15,

       s16.AWARD_ID as Project16,
       s16.SponsorName as Agency16,
       s16.SponsorID as AgNo16,
       s16.Sponsor_Type as AgencyType16, 
       s16.Title as Title16,

      s17.AWARD_ID as Project17,
      s17.SponsorName as Agency17,
      s17.SponsorID as AgNo17,
      s17.Sponsor_Type as AgencyType17, 
      s17.Title as Title17,

      s18.AWARD_ID as Project18,
      s18.SponsorName as Agency18,
      s18.SponsorID as AgNo18,
      s18.Sponsor_Type as AgencyType18, 
      s18.Title as Title18

from work.bondproj1 bp
left join work.Span2 s2
on bp.AWARD_INV_UFID=s2.AWARD_INV_UFID
left join work.Span3 s3
on bp.AWARD_INV_UFID=s3.AWARD_INV_UFID
left join work.Span4 s4
on bp.AWARD_INV_UFID=s4.AWARD_INV_UFID
left join work.Span5 s5
on bp.AWARD_INV_UFID=s5.AWARD_INV_UFID
left join work.Span6 s6
on bp.AWARD_INV_UFID=s6.AWARD_INV_UFID
left join work.Span7 s7
on bp.AWARD_INV_UFID=s7.AWARD_INV_UFID
left join work.Span8 s8
on bp.AWARD_INV_UFID=s8.AWARD_INV_UFID
left join work.Span9 s9
on bp.AWARD_INV_UFID=s9.AWARD_INV_UFID
left join work.Span10 s10
on bp.AWARD_INV_UFID=s10.AWARD_INV_UFID
left join work.Span11 s11
on bp.AWARD_INV_UFID=s11.AWARD_INV_UFID
left join work.Span12 s12
on bp.AWARD_INV_UFID=s12.AWARD_INV_UFID
left join work.Span13 s13
on bp.AWARD_INV_UFID=s13.AWARD_INV_UFID
left join work.Span14 s14
on bp.AWARD_INV_UFID=s14.AWARD_INV_UFID
left join work.Span15 s15
on bp.AWARD_INV_UFID=s15.AWARD_INV_UFID
left join work.Span16 s16
on bp.AWARD_INV_UFID=s16.AWARD_INV_UFID
left join work.Span17 s17
on bp.AWARD_INV_UFID=s17.AWARD_INV_UFID
left join work.Span18 s18
on bp.AWARD_INV_UFID=s18.AWARD_INV_UFID;

Drop Table if Exists work.SurveyTable2;
create table work.SurveyTable2 as
Select st1.AWARD_INV_UFID,
              st1.LastName,
              st1.FirstName,
              st1.email,
              st1.Project1,
              st1.Agency1,
              st1.AgNo1,
              st1.AgencyType1,
              st1.Title1,
              st1.Project2,
              st1.Agency2,
              st1.AgNo2,
              st1.AgencyType2,
              st1.Title2,
              st1.Project3,
              st1.Agency3,
              st1.AgNo3,
              st1.AgencyType3,
              st1.Title3,
              st1.Project4,
              st1.Agency4,
              st1.AgNo4,
              st1.AgencyType4,
              st1.Title4,
              st1.Project5,
              st1.Agency5,
              st1.AgNo5,
              st1.AgencyType5,
              st1.Title5,
              st1.Project6,
              st1.Agency6,
              st1.AgNo6,
              st1.AgencyType6,
              st1.Title6,
              st1.Project7,
              st1.Agency7,
              st1.AgNo7,
              st1.AgencyType7,
              st1.Title7,
              st1.Project8,
              st1.Agency8,
              st1.AgNo8,
              st1.AgencyType8,
              st1.Title8,
              st1.Project9,
              st1.Agency9,
              st1.AgNo9,
              st1.AgencyType9,
              st1.Title9,
              st1.Project10,
              st1.Agency10,
              st1.AgNo10,
              st1.AgencyType10,
              st1.Title10,
              st1.Project11,
              st1.Agency11,
              st1.AgNo11,
              st1.AgencyType11,
              st1.Title11,
              st1.Project12,
              st1.Agency12,
              st1.AgNo12,
              st1.AgencyType12,
              st1.Title12,
              st1.Project13,
              st1.Agency13,
              st1.AgNo13,
              st1.AgencyType13,
              st1.Title13,
              st1.Project14,
              st1.Agency14,
              st1.AgNo14,
              st1.AgencyType14,
              st1.Title14,
              st1.Project15,
              st1.Agency15,
              st1.AgNo15,
              st1.AgencyType15,
              st1.Title15,
              st1.Project16,
              st1.Agency16,
              st1.AgNo16,
              st1.AgencyType16,
              st1.Title16,
              st1.Project17,
              st1.Agency17,
              st1.AgNo17,
              st1.AgencyType17,
              st1.Title17,
              st1.Project18,
              st1.Agency18,
              st1.AgNo18,
              st1.AgencyType18,
              st1.Title18,

      s19.AWARD_ID as Project19,
      s19.SponsorName as Agency19,
      s19.SponsorID as AgNo19,
      s19.Sponsor_Type as AgencyType19, 
      s19.Title as Title19,

      s20.AWARD_ID as Project20,
      s20.SponsorName as Agency20,
      s20.SponsorID as AgNo20,
      s20.Sponsor_Type as AgencyType20, 
      s20.Title as Title20,

      s21.AWARD_ID as Project21,
      s21.SponsorName as Agency21,
      s21.SponsorID as AgNo21,
      s21.Sponsor_Type as AgencyType21, 
      s21.Title as Title21,

      s22.AWARD_ID as Project22,
      s22.SponsorName as Agency22,
      s22.SponsorID as AgNo22,
      s22.Sponsor_Type as AgencyType22, 
      s22.Title as Title22,

      s23.AWARD_ID as Project23,
      s23.SponsorName as Agency23,
      s23.SponsorID as AgNo23,
      s23.Sponsor_Type as AgencyType23, 
      s23.Title as Title23,

      s24.AWARD_ID as Project24,
      s24.SponsorName as Agency24,
      s24.SponsorID as AgNo24,
      s24.Sponsor_Type as AgencyType24, 
      s24.Title as Title24,

      s25.AWARD_ID as Project25,
      s25.SponsorName as Agency25,
      s25.SponsorID as AgNo25,
      s25.Sponsor_Type as AgencyType25, 
      s25.Title as Title25



from work.SurveyTable1 st1
left join work.Span19 s19
on st1.AWARD_INV_UFID=s19.AWARD_INV_UFID
left join work.Span20 s20
on st1.AWARD_INV_UFID=s20.AWARD_INV_UFID
left join work.Span21 s21
on st1.AWARD_INV_UFID=s21.AWARD_INV_UFID
left join work.Span22 s22
on st1.AWARD_INV_UFID=s22.AWARD_INV_UFID
left join work.Span23 s23
on st1.AWARD_INV_UFID=s23.AWARD_INV_UFID
left join work.Span24 s24
on st1.AWARD_INV_UFID=s24.AWARD_INV_UFID
left join work.Span25 s25
on st1.AWARD_INV_UFID=s25.AWARD_INV_UFID
ORDER BY st1.LastName, st1.FirstName;


Drop table if exists space.SurveyTable;
create table space.SurveyTable AS
select * from work.SurveyTable2;


Drop table if exists space.SurveyTableTEST;
create table space.SurveyTableTEST AS
select * from work.SurveyTable2;

## FOR TESTING
SET SQL_SAFE_UPDATES = 0;

UPDATE space.SurveyTableTEST SET EMAIL="edneu@ufl.edu";

## END TESTING


## End of RED Make Survey Data