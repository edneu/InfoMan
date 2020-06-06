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

#######
Drop Table if Exists work.Span26;
create table work.Span26 as
select * from work.survey_bondmaster where Span=26;

Drop Table if Exists work.Span27;
create table work.Span27 as
select * from work.survey_bondmaster where Span=27;

Drop Table if Exists work.Span28;
create table work.Span28 as
select * from work.survey_bondmaster where Span=28;

Drop Table if Exists work.Span29;
create table work.Span29 as
select * from work.survey_bondmaster where Span=29;

Drop Table if Exists work.Span30;
create table work.Span30 as
select * from work.survey_bondmaster where Span=30;

Drop Table if Exists work.Span31;
create table work.Span31 as
select * from work.survey_bondmaster where Span=31;

Drop Table if Exists work.Span32;
create table work.Span32 as
select * from work.survey_bondmaster where Span=32;

Drop Table if Exists work.Span33;
create table work.Span33 as
select * from work.survey_bondmaster where Span=33;

Drop Table if Exists work.Span34;
create table work.Span34 as
select * from work.survey_bondmaster where Span=34;

Drop Table if Exists work.Span35;
create table work.Span35 as
select * from work.survey_bondmaster where Span=35;

Drop Table if Exists work.Span36;
create table work.Span36 as
select * from work.survey_bondmaster where Span=36;

Drop Table if Exists work.Span37;
create table work.Span37 as
select * from work.survey_bondmaster where Span=37;

Drop Table if Exists work.Span38;
create table work.Span38 as
select * from work.survey_bondmaster where Span=38;

Drop Table if Exists work.Span39;
create table work.Span39 as
select * from work.survey_bondmaster where Span=39;

Drop Table if Exists work.Span40;
create table work.Span40 as
select * from work.survey_bondmaster where Span=40;

Drop Table if Exists work.Span41;
create table work.Span41 as
select * from work.survey_bondmaster where Span=41;

Drop Table if Exists work.Span42;
create table work.Span42 as
select * from work.survey_bondmaster where Span=42;

Drop Table if Exists work.Span43;
create table work.Span43 as
select * from work.survey_bondmaster where Span=43;

Drop Table if Exists work.Span44;
create table work.Span44 as
select * from work.survey_bondmaster where Span=44;

Drop Table if Exists work.Span45;
create table work.Span45 as
select * from work.survey_bondmaster where Span=45;

Drop Table if Exists work.Span46;
create table work.Span46 as
select * from work.survey_bondmaster where Span=46;

Drop Table if Exists work.Span47;
create table work.Span47 as
select * from work.survey_bondmaster where Span=47;
############################################################################################





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

####################################################### TABLE 2

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
##################################################################################
###################### TABLE 3
##################################################################################
Drop Table if Exists work.SurveyTable3;
create table work.SurveyTable3 as
Select st2.AWARD_INV_UFID,
              st2.LastName,
              st2.FirstName,
              st2.email,
             st2.Project1,
              st2.Agency1,
              st2.AgNo1,
              st2.AgencyType1,
              st2.Title1,
             st2.Project2,
              st2.Agency2,
              st2.AgNo2,
              st2.AgencyType2,
              st2.Title2,
             st2.Project3,
              st2.Agency3,
              st2.AgNo3,
              st2.AgencyType3,
              st2.Title3,
             st2.Project4,
              st2.Agency4,
              st2.AgNo4,
              st2.AgencyType4,
              st2.Title4,
             st2.Project5,
              st2.Agency5,
              st2.AgNo5,
              st2.AgencyType5,
              st2.Title5,
             st2.Project6,
              st2.Agency6,
              st2.AgNo6,
              st2.AgencyType6,
              st2.Title6,
             st2.Project7,
              st2.Agency7,
              st2.AgNo7,
              st2.AgencyType7,
              st2.Title7,
             st2.Project8,
              st2.Agency8,
              st2.AgNo8,
              st2.AgencyType8,
              st2.Title8,
             st2.Project9,
              st2.Agency9,
              st2.AgNo9,
              st2.AgencyType9,
              st2.Title9,
             st2.Project10,
              st2.Agency10,
              st2.AgNo10,
              st2.AgencyType10,
              st2.Title10,
             st2.Project11,
              st2.Agency11,
              st2.AgNo11,
              st2.AgencyType11,
              st2.Title11,
             st2.Project12,
              st2.Agency12,
              st2.AgNo12,
              st2.AgencyType12,
              st2.Title12,
             st2.Project13,
              st2.Agency13,
              st2.AgNo13,
              st2.AgencyType13,
              st2.Title13,
             st2.Project14,
              st2.Agency14,
              st2.AgNo14,
              st2.AgencyType14,
              st2.Title14,
             st2.Project15,
              st2.Agency15,
              st2.AgNo15,
              st2.AgencyType15,
              st2.Title15,
             st2.Project16,
              st2.Agency16,
              st2.AgNo16,
              st2.AgencyType16,
              st2.Title16,
             st2.Project17,
              st2.Agency17,
              st2.AgNo17,
              st2.AgencyType17,
              st2.Title17,
             st2.Project18,
              st2.Agency18,
              st2.AgNo18,
              st2.AgencyType18,
              st2.Title18,
             st2.Project19,
              st2.Agency19,
              st2.AgNo19,
              st2.AgencyType19,
              st2.Title19,
             st2.Project20,
              st2.Agency20,
              st2.AgNo20,
              st2.AgencyType20,
              st2.Title20,
              st2.Project21,
              st2.Agency21,
              st2.AgNo21,
              st2.AgencyType21,
              st2.Title21,
             st2.Project22,
              st2.Agency22,
              st2.AgNo22,
              st2.AgencyType22,
              st2.Title22,
             st2.Project23,
              st2.Agency23,
              st2.AgNo23,
              st2.AgencyType23,
              st2.Title23,
             st2.Project24,
              st2.Agency24,
              st2.AgNo24,
              st2.AgencyType24,
              st2.Title24,
			st2.Project25,
              st2.Agency25,
              st2.AgNo25,
              st2.AgencyType25,
              st2.Title25,

      s26.AWARD_ID as Project26,
      s26.SponsorName as Agency26,
      s26.SponsorID as AgNo26,
      s26.Sponsor_Type as AgencyType26, 
      s26.Title as Title26,

      s27.AWARD_ID as Project27,
      s27.SponsorName as Agency27,
      s27.SponsorID as AgNo27,
      s27.Sponsor_Type as AgencyType27, 
      s27.Title as Title27,
	

      s28.AWARD_ID as Project28,
      s28.SponsorName as Agency28,
      s28.SponsorID as AgNo28,
      s28.Sponsor_Type as AgencyType28, 
      s28.Title as Title28,


      s29.AWARD_ID as Project29,
      s29.SponsorName as Agency29,
      s29.SponsorID as AgNo29,
      s29.Sponsor_Type as AgencyType29, 
      s29.Title as Title29,

      s30.AWARD_ID as Project30,
      s30.SponsorName as Agency30,
      s30.SponsorID as AgNo30,
      s30.Sponsor_Type as AgencyType30, 
      s30.Title as Title30,

      s31.AWARD_ID as Project31,
      s31.SponsorName as Agency31,
      s31.SponsorID as AgNo31,
      s31.Sponsor_Type as AgencyType31, 
      s31.Title as Title31,

      s32.AWARD_ID as Project32,
      s32.SponsorName as Agency32,
      s32.SponsorID as AgNo32,
      s32.Sponsor_Type as AgencyType32, 
      s32.Title as Title32,

      s33.AWARD_ID as Project33,
      s33.SponsorName as Agency33,
      s33.SponsorID as AgNo33,
      s33.Sponsor_Type as AgencyType33, 
      s33.Title as Title33,

      s34.AWARD_ID as Project34,
      s34.SponsorName as Agency34,
      s34.SponsorID as AgNo34,
      s34.Sponsor_Type as AgencyType34, 
      s34.Title as Title34,

      s35.AWARD_ID as Project35,
      s35.SponsorName as Agency35,
      s35.SponsorID as AgNo35,
      s35.Sponsor_Type as AgencyType35, 
      s35.Title as Title35,

      s36.AWARD_ID as Project36,
      s36.SponsorName as Agency36,
      s36.SponsorID as AgNo36,
      s36.Sponsor_Type as AgencyType36, 
      s36.Title as Title36,

      s37.AWARD_ID as Project37,
      s37.SponsorName as Agency37,
      s37.SponsorID as AgNo37,
      s37.Sponsor_Type as AgencyType37, 
      s37.Title as Title37,

      s38.AWARD_ID as Project38,
      s38.SponsorName as Agency38,
      s38.SponsorID as AgNo38,
      s38.Sponsor_Type as AgencyType38, 
      s38.Title as Title38,

      s39.AWARD_ID as Project39,
      s39.SponsorName as Agency39,
      s39.SponsorID as AgNo39,
      s39.Sponsor_Type as AgencyType39, 
      s39.Title as Title39,

      s40.AWARD_ID as Project40,
      s40.SponsorName as Agency40,
      s40.SponsorID as AgNo40,
      s40.Sponsor_Type as AgencyType40, 
      s40.Title as Title40,

      s41.AWARD_ID as Project41,
      s41.SponsorName as Agency41,
      s41.SponsorID as AgNo41,
      s41.Sponsor_Type as AgencyType41, 
      s41.Title as Title41,

      s42.AWARD_ID as Project42,
      s42.SponsorName as Agency42,
      s42.SponsorID as AgNo42,
      s42.Sponsor_Type as AgencyType42, 
      s42.Title as Title42,

      s43.AWARD_ID as Project43,
      s43.SponsorName as Agency43,
      s43.SponsorID as AgNo43,
      s43.Sponsor_Type as AgencyType43, 
      s43.Title as Title43,

      s44.AWARD_ID as Project44,
      s44.SponsorName as Agency44,
      s44.SponsorID as AgNo44,
      s44.Sponsor_Type as AgencyType44, 
      s44.Title as Title44,

      s45.AWARD_ID as Project45,
      s45.SponsorName as Agency45,
      s45.SponsorID as AgNo45,
      s45.Sponsor_Type as AgencyType45, 
      s45.Title as Title45,

      s46.AWARD_ID as Project46,
      s46.SponsorName as Agency46,
      s46.SponsorID as AgNo46,
      s46.Sponsor_Type as AgencyType46, 
      s46.Title as Title46,

      s47.AWARD_ID as Project47,
      s47.SponsorName as Agency47,
      s47.SponsorID as AgNo47,
      s47.Sponsor_Type as AgencyType47, 
      s47.Title as Title47

from work.SurveyTable2 st2
	left join work.Span26 s26 on st2.AWARD_INV_UFID=s26.AWARD_INV_UFID
	left join work.Span27 s27 on st2.AWARD_INV_UFID=s27.AWARD_INV_UFID
	left join work.Span28 s28 on st2.AWARD_INV_UFID=s28.AWARD_INV_UFID
	left join work.Span29 s29 on st2.AWARD_INV_UFID=s29.AWARD_INV_UFID
	left join work.Span30 s30 on st2.AWARD_INV_UFID=s30.AWARD_INV_UFID
	left join work.Span31 s31 on st2.AWARD_INV_UFID=s31.AWARD_INV_UFID
	left join work.Span32 s32 on st2.AWARD_INV_UFID=s32.AWARD_INV_UFID
	left join work.Span33 s33 on st2.AWARD_INV_UFID=s33.AWARD_INV_UFID
	left join work.Span34 s34 on st2.AWARD_INV_UFID=s34.AWARD_INV_UFID
	left join work.Span35 s35 on st2.AWARD_INV_UFID=s35.AWARD_INV_UFID
	left join work.Span36 s36 on st2.AWARD_INV_UFID=s36.AWARD_INV_UFID
	left join work.Span37 s37 on st2.AWARD_INV_UFID=s37.AWARD_INV_UFID
	left join work.Span38 s38 on st2.AWARD_INV_UFID=s38.AWARD_INV_UFID
	left join work.Span39 s39 on st2.AWARD_INV_UFID=s39.AWARD_INV_UFID
	left join work.Span40 s40 on st2.AWARD_INV_UFID=s40.AWARD_INV_UFID
	left join work.Span41 s41 on st2.AWARD_INV_UFID=s41.AWARD_INV_UFID
	left join work.Span42 s42 on st2.AWARD_INV_UFID=s42.AWARD_INV_UFID
	left join work.Span43 s43 on st2.AWARD_INV_UFID=s43.AWARD_INV_UFID
	left join work.Span44 s44 on st2.AWARD_INV_UFID=s44.AWARD_INV_UFID
	left join work.Span45 s45 on st2.AWARD_INV_UFID=s45.AWARD_INV_UFID
	left join work.Span46 s46 on st2.AWARD_INV_UFID=s46.AWARD_INV_UFID
	left join work.Span47 s47 on st2.AWARD_INV_UFID=s47.AWARD_INV_UFID
ORDER BY st2.LastName, st2.FirstName;

##################################################################################
######################  END TABLE 3
##################################################################################
##################################################################################
##################################################################################


Drop table if exists space.SurveyTable;
create table space.SurveyTable AS
select * from work.SurveyTable3;


Drop table if exists space.SurveyTableTEST;
create table space.SurveyTableTEST AS
select * from work.SurveyTable3;

## FOR TESTING
SET SQL_SAFE_UPDATES = 0;

UPDATE space.SurveyTableTEST SET EMAIL="edneu@ufl.edu";

## END TESTING
select * from work.Span47;

## End of RED Make Survey Data

drop table if exists space.xxx;
create table space.xxx as
SELECT bondmaster_key,Span, AWARD_INV_UFID,LastName,FirstName,AWARD_ID_TYPE,Award_ID,AWARD_ID_Number,SponsorName,SponsorID,Title,Total_Award,IP_USAGE
FROM space.bondmaster WHERE AWARD_INV_UFID="51342270";