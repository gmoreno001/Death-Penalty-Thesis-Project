
clear
global fileloc "set_your_file_path_here"

***********************************
// DEATH PENALTY USAGE DATA //
***********************************
* https://deathpenaltyinfo.org/executions/execution-database

insheet using "$fileloc\County_Level_Death_Penalty_1214.csv" 

****************************************
// ACS 2008 to 2012 5-YEAR ESTIMATES //
****************************************
* https://www.census.gov/programs-surveys/acs/technical-documentation/table-and-geography-changes/2012/5-year.html

//Total Population
gen totalpop=B01001_001
label variable totalpop "Total Population"

//Population Males age 15-24 
gen malepop1524=B01001_006 + B01001_007 + B01001_008 + B01001_009 + B01001_010
label variable malepop1524 "Population Males age 15-24"

//Population Males age 15-29 
gen malepop1529=B01001_006 + B01001_007 + B01001_008 + B01001_009 + B01001_010 + B01001_011
label variable malepop1529 "Population Males age 15-29"

//Population Females age 15-24
gen fmalepop1524=B01001_030 + B01001_031 + B01001_032 + B01001_033 + B01001_034
label variable fmalepop1524 "Population Females age 15-24"

//Population Females age 15-29 
gen fmalepop1529=B01001_030 + B01001_031 + B01001_032 + B01001_033 + B01001_034 + B01001_035
label variable fmalepop1529 "Population Females age 15-29"

//Total Population Age 15-24 
gen pop1524=malepop1524 + fmalepop1524
label variable pop1524 "Total Population Age 15-24"

//Total Population Age 15-29
gen pop1529=fmalepop1529 + malepop1529
label variable pop1529 "Total Population Age 15-29"

//Total Population Over Age 15
gen popover15 = pop1529 + B01001_012 + B01001_013 + B01001_014 + B01001_015 + B01001_016 + B01001_017 + B01001_018 ///
+ B01001_019 + B01001_020 + B01001_021 + B01001_022 + B01001_023 + B01001_024 + B01001_025 + B01001_036 + B01001_037 ///
+ B01001_038 + B01001_039 + B01001_040 + B01001_041 + B01001_042 + B01001_043 + B01001_044 + B01001_045 + B01001_046 ///
+ B01001_047 + B01001_048 + B01001_049
label variable popover15 "Total Population Over Age 15"

//Percent Population Ages 15-24 
gen p1524=(pop1524/totalpop)*100
replace p1524=0 if p1524==. & totalpop==0
label variable p1524 "Percent Population Ages 15-24"

//Percent Population Ages 15-29
gen p1529=(pop1529/totalpop)*100
replace p1529=0 if p1529==. & totalpop==0
label variable p1529 "Percent Population Ages 15-29"
 
//Total White/Latino Population
gen whitelatpop = B03002_013
label variable whitelatpop "Total White/Latino Population" 

//Total Non-Latino White Population
gen nlwhitepop = B03002_003
label variable nlwhitepop "Total Non-Latino White Population"
 
//Total Blk/Latino Population
gen blklatpop = B03002_014
label variable blklatpop "Total Blk/Latino Population"

//Percent Population Non-Latino Black
gen nlblkpop = B03002_004
summ totalpop nlblkpop
gen pnlb = (nlblkpop/totalpop)*100
replace pnlb=0 if pnlb==. & totalpop==0
label variable pnlb "Percent Population Non-Latino Black"

//Percent Population Latino
gen latpop = B03002_012
summ totalpop latpop
gen plat = (latpop/totalpop)*100
replace plat=0 if latpop==. & totalpop==0
replace plat=0 if latpop==0 & totalpop==0
label variable plat "Percent Population Latino"

//Total Families
gen totfam = B11003_001 
label variable totfam "Total Families"

//Total Number of Families
gen tot_fam = B19101_001 
label variable tot_fam "Total Number of Families"

//Families Below Poverty Level
gen fambelpov=B17010_002
label variable fambelpov "Families Below Poverty Level"

//Percent of Families Below Poverty Level
gen pctfambelpov=(fambelpov/totfam)*100
replace pctfambelpov=0 if (fambelpov==0) 
replace pctfambelpov=0 if (totfam==0)
label variable pctfambelpov "Percent of Families Below Poverty Level"
 
//Families Above Poverty Level
gen famabvpov=B17010_022
label variable famabvpov "Families Above Poverty Level"

//Percent of Families Above Poverty Level
gen pctfamabvpov=(famabvpov/totfam)*100
replace pctfamabvpov=0 if (famabvpov==0) 
replace pctfamabvpov=0 if (totfam==0)
label variable pctfamabvpov "Percent of Families Above Poverty Level"

//Median Household Income
gen medhhinc=B19013_001
label variable medhhinc "Median Household Income (In 2018 Dollars)"

//Public Assitance 
gen hh_pa=B19057_002
label variable hh_pa "Total Number of Households with Public Assistance Income"
gen tot_hh=B19001_001
label variable tot_hh "Total Number of Households"
gen pcthh_pa=(hh_pa/tot_hh)*100
label variable pcthh_pa "Percent of Households with Public Assistance Income"

//Population 16 and Over in Civilian Labor Force <tot_16ovr_clf>
gen tot_16ovr_clf = B23001_006 + B23001_013 + B23001_020 + B23001_027 + B23001_034 + ///
B23001_041 + B23001_048 + B23001_055 + B23001_062 + B23001_069 + B23001_074 + B23001_079 + ///
B23001_084 + B23001_092 + B23001_099 + B23001_106 + B23001_113 + B23001_120 + B23001_127 + ///
B23001_134 + B23001_141 + B23001_148 + B23001_155 + B23001_160 + B23001_165 + B23001_170
label variable tot_16ovr_clf "Total Population 16 and Over in the Civilian Labor Force"

//Population 16 and Over in Civilian Labor Force who are Also Unemployed <tot_16ovr_clf_unemp>
gen tot_16ovr_clf_unemp = B23001_008 + B23001_015 + B23001_022 + B23001_029 + B23001_036 + ///
B23001_043 + B23001_050 + B23001_057 + B23001_064 + B23001_071 + B23001_076 + B23001_081 + ///
B23001_086 + B23001_094 + B23001_101 + B23001_108 + B23001_115 + B23001_122 + B23001_129 + ///
B23001_136 + B23001_143 + B23001_150 + B23001_157 + B23001_162 + B23001_167 + B23001_172
label variable tot_16ovr_clf_unemp "Total Population 16 and Over in the Civilian Labor Force and Unemployed"

//Percent of Population 16 and Over in the CLF that is Unemployed <pct_16ovr_clf_unemp>
gen pct_16ovr_clf_unemp = (tot_16ovr_clf_unemp/tot_16ovr_clf)*100
replace pct_16ovr_clf_unemp = 0 if (tot_16ovr_clf_unemp==0) 
replace pct_16ovr_clf_unemp = 0 if (tot_16ovr_clf==0)
label variable pct_16ovr_clf_unemp "Percent of Population 16 and Over in the CLF that is Unemployed"

//Total Population 16-64 in the Civilian Labor Force <tot_1664_clf>
gen tot_1664_clf = B23001_006 + B23001_013 + B23001_020 + B23001_027 + B23001_034 + B23001_041 + ///
B23001_048 + B23001_055 + B23001_062 + B23001_069 + B23001_092 + B23001_099 + B23001_106 + ///
B23001_113 + B23001_120 + B23001_127 + B23001_134 + B23001_141 + B23001_148 + B23001_155
label variable tot_1664_clf "Total Population 16-64 in the Civilian Labor Force"

//Total Population 16-64 in the Civilian Labor Force and Unemployed <tot_1664_clf_unemp>
gen tot_1664_clf_unemp = B23001_008 + B23001_015 + B23001_022 + B23001_029 + B23001_036 + B23001_043 ///
+ B23001_050 + B23001_057 + B23001_064 + B23001_071 + B23001_094 + B23001_101 + B23001_108 + B23001_115 ///
+ B23001_122 + B23001_129 + B23001_136 + B23001_143 + B23001_150 + B23001_157
label variable tot_1664_clf_unemp "Total Population 16-64 in the Civilian Labor Force and Unemployed"

//Percent of Population 16-64 in the CLF that is Unemployed
gen pct_1664_clf_unemp = (tot_1664_clf_unemp/tot_1664_clf)*100
replace pct_1664_clf_unemp=0 if (tot_1664_clf_unemp==0) 
replace pct_1664_clf_unemp=0 if (tot_1664_clf==0)
label variable pct_1664_clf_unemp "Percent of Population 16-64 in the CLF that is Unemployed"

//Total Population 16-64 in the Armed Forces
gen tot_1664_armforc = B23001_005 + B23001_012 + B23001_019 + B23001_026 + B23001_033 + B23001_040 + ///
B23001_047 + B23001_054 + B23001_061 + B23001_068 + B23001_091 + B23001_098 + B23001_105 + B23001_112 + ///
B23001_119 + B23001_126 + B23001_133 + B23001_140 + B23001_147 + B23001_154
label variable tot_1664_armforc "Total Population 16-64 in the Armed Forces"

//Total Population 16-64 Not in the Labor Force
gen tot_1664_notinlf = B23001_009 + B23001_016 + B23001_023 + B23001_030 + B23001_037 + B23001_044 + ///
B23001_051 + B23001_058 + B23001_065 + B23001_072 + B23001_095 + B23001_102 + B23001_109 + B23001_116 + ///
B23001_123 + B23001_130 + B23001_137 + B23001_144 + B23001_151 + B23001_158 
label variable tot_1664_notinlf "Total Population 16-64 Not in the Labor Force"
 
//Total Population 16-64
gen tot_pop_1664 = B23001_003 + B23001_010 + B23001_017 + B23001_024 + B23001_031 + B23001_038 + B23001_045 + ///
B23001_052 + B23001_059 + B23001_066 + B23001_089 + B23001_096 + B23001_103 + B23001_110 + B23001_117 + ///
B23001_124 + B23001_131 + B23001_138 + B23001_145 + B23001_152
label variable tot_pop_1664 "Total Population 16-64"

//Percent of Civilians 16-64 not in the Labor Force
gen pct_1664_civ_notinlf=((tot_1664_notinlf)/(tot_pop_1664-tot_1664_armforc))*100
replace pct_1664_civ_notinlf=0 if (tot_pop_1664==0) 
replace pct_1664_civ_notinlf=0 if (tot_1664_notinlf==0)
label variable pct_1664_civ_notinlf "Percent of Civilians 16-64 not in the Labor Force"

//Foreign Born Population
gen fbornpop=B05002_013
label variable fbornpop "Foreign Born Population"

//Percent Foreign Born Population
gen pctfborn=(fbornpop/totalpop)*100 
replace pctfborn=0 if (fbornpop==0) 
replace pctfborn=0 if (totalpop==0)
label variable pctfborn "Percent Foreign Born Population"

//Total Population over 1 Year Old
gen popover1=B07001_001
label variable popover1 "Total Population over 1 Year Old"

//Population in Same House 1 Year Ago
gen samehhpop=B07001_017
label variable samehhpop "Population in Same House 1 Year Ago"

//Percent Population over 1 in same House 1 Year Ago
gen pct_samehh1yr=(samehhpop/popover1)*100
replace pct_samehh1yr=0 if (samehhpop==0) 
replace pct_samehh1yr=0 if (popover1==0)
label variable pct_samehh1yr "Percent Population over 1 in same House 1 Year Ago" 
 
//Total Households
gen tothh=B11001_001
label variable tothh "Total Households"

//Female Headed Households
gen femhh=B11001_006
label variable femhh "Female Headed Households"

//Percent Female Headed Households
gen pfemhh=(femhh/tothh)*100
replace pfemhh=0 if (femhh==0) 
replace pfemhh=0 if (tothh==0)
label variable pfemhh "Percent Female Headed Households"

//Total Families
gen totfam=B11003_001
label variable totfam "Total Families"

//Female Householder Families with Kids <18
gen femfamk=B11003_016
label variable femfamk "Female Householder Families with Kids <18"

//Percent Female Householder Families with Kids <18
gen pctfemfamk=(femfamk/totfam)*100
replace pctfemfamk=0 if (femfamk==0) 
replace pctfemfamk=0 if (totfam==0)
label variable pctfemfamk "Percent Female Householder Families with Kids <18" 
 

***********************************
// ARDA RELIGION DATA //
***********************************
* https://www.thearda.com/Archive/Files/Downloads/RCMSCY10_DL2.asp

clear
global fileloc "set_your_file_path_here"
use "$fileloc\01_Raw_Data\U.S. Religion Census Religious Congregations and Membership Study, 2010 (County File).dta" 
keep stcode cntycode cntyname totrate evanrate bprtrate mprtrate cathrate orthrate cthrate
rename stcode state_n
rename cntycode county_n
save "$fileloc\02_Prepped_Data\County_Religion_Data_2010.dta", replace


*************************************
// GUARDIAN ELECTION VOTING DATA //
***********************************
* https://www.theguardian.com/news/datablog/2012/nov/07/us-2012-election-county-results-download#data 

clear
global fileloc "set_your_file_path_here"
insheet using "$fileloc\01_Raw_Data\US_elect_county.csv", comma clear 
renvars statepostal obamavote romneyvote \ stab ovotes rvotes
destring ovotes, replace ignore(,)
destring rvotes, replace ignore(,)
sort fips
drop if fips==0
//Aggregate by county//
collapse (first) stab (sum) ovotes rvotes, by(fips)
//Generate a % republican vote variable//
gen p_repub= (rvotes/(ovotes +rvotes))*100
label var p_repub "% Republic (Romney) Voters, 2012"
sum p_rep
rename fips fips_n
save "$fileloc\02_Prepped_Data\Guardian_County_Voting_Data_2012.dta", replace


*********************
// UCR CRIME DATA //
*********************
* https://www.icpsr.umich.edu/web/ICPSR/studies/35019/versions/V1/download/stata?path=/pcms/studies/0/3/5/0/35019/V1

clear
global fileloc "set_your_file_path_here"
use "$fileloc\01_Raw_Data\35019-0001-Data"
keep FIPS_ST FIPS_CTY MURDER P1VLNT RAPE ROBBERY AGASSLT
rename FIPS_ST state_n
rename FIPS_CTY county_n
save "$fileloc\02_Prepped_Data\UCR_Crimes_2012.dta", replace


******************************
// BJS INCARCERATION DATA //
******************************
* https://www.bjs.gov/content/pub/pdf/p12ac.pdf

clear
global fileloc "set_your_file_path_here"
import excel "$fileloc\01_Raw_Data\Incarceration_1213_BJS.xls", sheet ("BJS_Incarceration_1213") firstrow allstring
destring incar2012, replace ignore(-- ,)
destring mincar2012, replace ignore(-- ,)
destring fincar2012, replace ignore(--)
destring incar2013, replace ignore(--)
destring mincar2013, replace ignore(-- ,)
destring fincar2013, replace ignore(--)

**State Name to FIPS**
rename Statecde stname
gen state_n=-1
replace state_n=2 if stname=="Alaska/d,e,g"
replace state_n=1 if stname=="Alabama"
replace state_n=5 if stname=="Arkansas"
replace state_n=60 if stname=="American Samoa"
replace state_n=4 if stname=="Arizona"
replace state_n=6 if stname=="California"
replace state_n=8 if stname=="Colorado"
replace state_n=9 if stname=="Connecticut/g"
replace state_n=11 if stname=="District Of Columbia"
replace state_n=10 if stname=="Delaware/g"
replace state_n=12 if stname=="Florida"
replace state_n=13 if stname=="Georgia"
replace state_n=66 if stname=="Guam"
replace state_n=15 if stname=="Hawaii/g"
replace state_n=19 if stname=="Iowa"
replace state_n=16 if stname=="Idaho"
replace state_n=17 if stname=="Illinois/h"
replace state_n=18 if stname=="Indiana/i"
replace state_n=20 if stname=="Kansas"
replace state_n=21 if stname=="Kentucky"
replace state_n=22 if stname=="Louisiana"
replace state_n=25 if stname=="Massachusetts"
replace state_n=24 if stname=="Maryland"
replace state_n=23 if stname=="Maine"
replace state_n=26 if stname=="Michigan"
replace state_n=27 if stname=="Minnesota"
replace state_n=29 if stname=="Missouri"
replace state_n=28 if stname=="Mississippi"
replace state_n=30 if stname=="Montana"
replace state_n=37 if stname=="North Carolina"
replace state_n=38 if stname=="North Dakota"
replace state_n=31 if stname=="Nebraska"
replace state_n=33 if stname=="New Hampshire"
replace state_n=34 if stname=="New Jersey"
replace state_n=35 if stname=="New Mexico"
replace state_n=32 if stname=="Nevada/h,j"
replace state_n=36 if stname=="New York"
replace state_n=39 if stname=="Ohio"
replace state_n=40 if stname=="Oklahoma/i"
replace state_n=41 if stname=="Oregon"
replace state_n=42 if stname=="Pennsylvania"
replace state_n=72 if stname=="Puerto Rico"
replace state_n=44 if stname=="Rhode Island/g"
replace state_n=45 if stname=="South Carolina"
replace state_n=46 if stname=="South Dakota"
replace state_n=47 if stname=="Tennessee"
replace state_n=48 if stname=="Texas"
replace state_n=49 if stname=="Utah"
replace state_n=51 if stname=="Virginia/i"
replace state_n=78 if stname=="Virgin Islands"
replace state_n=50 if stname=="Vermont/g"
replace state_n=53 if stname=="Washington/f"
replace state_n=55 if stname=="Wisconsin/i"
replace state_n=54 if stname=="West Virginia"
replace state_n=56 if stname=="Wyoming"
tab state_n
drop stname
save "$fileloc\02_Prepped_Data\BJS_State_Incarceration_Data_1213.dta", replace














