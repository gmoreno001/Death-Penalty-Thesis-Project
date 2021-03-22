clear
set more off

//SET WORKING DIRECTORY//
global fileloc "set_your_file_path_here"

//READ IN ANALYTIC FILE//
use "$fileloc\Death Penalty Thesis Data\Death_Penalty_Data_Final_For_MA_Thesis.dta" 

//CREATE SUM DEATH PENALTY USAGE//
gen sum_dp=death_sentence+execution
sum sum_dp
label var sum_dp "Sum Death Penalty Usage"

//CREATE COUNTY INDICATOR// 
gen cty_dp = 0
replace cty_dp=1 if death_sentence>=1
replace cty_dp=1 if execution>=1
sum cty_dp
tab cty_dp 
label var cty_dp "County Indicator of Death Penalty"

//CHECK VARIABLES//
br death_sentence execution sum_dp cty_dp

//CREATE VIOLENT CRIME RATE//
gen vcrimert= (P1VLNT / totalpop_0812)*100000
sum vcrimert
label var vcrimert "Violent Crime Rater Per, 100K HOM+Rape+ROBB+AGASS" 

//CREATE MURDER RATE//
gen murder_rate=MURDER/totalpop_0812*100000
sum murder_rate

//CREATE CONCENTRATED DISADVANTAGE INDEX//
egen z_pct_unemp = std(pct_16ovr_clf_unemp_0812) 
egen z_medhhinc = std(medhhinc_0812) 
replace z_medhhinc2 =  z_medhhinc * -1 //NOTE: THIS IS REVERSED 
egen z_pcthh_pa = std(pcthh_pa_0812) 
egen z_pctfambelpov = std(pctfambelpov_0812) 
gen disadv_index = z_pct_unemp + z_medhhinc + z_pcthh_pa + z_pctfambelpov

//CREATE EDUCATION INDEX//
egen z_h2 = std(phsd_0812)
egen z_hg2 = std(phsdged_0812)
egen z_ass2 = std(passoc_0812)
egen z_bac2 = std(pbach_0812)
egen z_mas2 = std(pmast_0812)
egen z_doc2 = std(pdocpro_0812)
egen edu_index2 = rowtotal(z_h2 - z_doc2)

//CREATE LOGGED POPULATION//
gen ln_pop=ln(totalpop_0812)
label variable ln_pop "Logged Population for Exposure"
sum ln_pop

//DESCRIPTIVES//
sum sum_dp p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812

//CORRELATIONS//
pwcorr p_repub pnlb_0812 plat_0812 phsdged_0812 phsd_0812 passoc_0812 pbach_0812 pmast_0812 ///
pdocpro_0812 incar2012 murder_rate vcrimert bprtrate cathrate totrate evanrate mprtrate orthrate ///
cthrate disadv_index pctbelpov_0812 pctabvpov_0812 pcthh_pa_0812 pcthh_pafs_0812 sum_dp, star(.05)

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*TABLE 2. DESCRIPTIVE STATISTICS FOR INDEPENDENT VARIABLES
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	  
//ALL DEATH PENALTY STATES
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if st_dp==1 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if st_dp==1 & cty_dp==0

//ALABAMA
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==01 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==01 & cty_dp==0

//CALIFORNIA
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==06 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==06 & cty_dp==0

//PENNSYLVANIA
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==42 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==42 & cty_dp==0

//FLORIDA
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==12 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==12 & cty_dp==0

//GEORGIA
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==13 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==13 & cty_dp==0

//OHIO
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==39 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==39 & cty_dp==0

//OKLAHOMA
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==40 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==40 & cty_dp==0

//TENNESSEE 
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==47 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==47 & cty_dp==0

//TEXAS
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==48 & cty_dp==1
sum p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if state_n==48 & cty_dp==0


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*TABLE 3. DESCRIPTIVE STATISTICS FOR DEPENDENT VARIABLE(S) IN DEATH PENALTY COUNTIES 
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//ALL STATES WITH DEATH PENALTY
sum death_sentence execution sum_dp if cty_dp==1 

//ALABAMA
sum death_sentence execution sum_dp if state_n==01 & cty_dp==1 

//CALIFORNIA
sum death_sentence execution sum_dp if state_n==06 & cty_dp==1 

//PENNSYLVANIA 
sum death_sentence execution sum_dp if state_n==42 & cty_dp==1 

//FLORIDA
sum death_sentence execution sum_dp if state_n==12 & cty_dp==1 

//GEORGIA
sum death_sentence execution sum_dp if state_n==13 & cty_dp==1

//OHIO 
sum death_sentence execution sum_dp if state_n==39 & cty_dp==1 

//OKLAHOMA
sum death_sentence execution sum_dp if state_n==40 & cty_dp==1 

//TENNESSEE
sum death_sentence execution sum_dp if state_n==47 & cty_dp==1

//TEXAS
sum death_sentence execution sum_dp if state_n==48 & cty_dp==1 

	  
*~~~~~~~~~~~~~~~~~~~~~~~~
* TABLE 5. CORRELATIONS 
*~~~~~~~~~~~~~~~~~~~~~~~~

//ALABAMA
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==01, star(.05)

//CALIFORNIA
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==06, star(.05)

//PENNSYLVANIA 
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==42, star(.05)

//FLORIDA
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==12, star(.05)

//GEORGIA
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==13, star(.05)

//OHIO 
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==39, star(.05)

//OKLAHOMA 
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==40, star(.05)

//TENNESSEE
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==47, star(.05)

//TEXAS
pwcorr p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 sum_dp if state_n==48, star(.05)


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* TABLE 6. RARE EVENTS LOGISTIC REGRESSION 
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
relogit capital p_repub pnlb_0812 phsdged_0812 incar2012 vcrimert cathrate pcthh_pafs_0812 if st_dp == 1


/*NOTE ON DOWNLOADING RELOGIT PACKAGE:
- Download the zipped file from here (https://gking.harvard.edu/scholar_software/relogit-rare-events-logistic-regression/1-1-stata)
- Once downloaded, extract files
- Run <sysdir> in Stata to navigate to the path where your Stata executable is stored 
- Paste the extracted relogit package files here: Your_Stata_File_Path\ado\updates\r 
*/


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* TABLE 7. NEGATIVE BINOMIAL REGRESSION
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//ALABAMA
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==1, exposure(ln_pop) 

//CALIFORNIA
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==6, exposure(ln_pop) 

//PENNSYLVANIA 
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==42, exposure(ln_pop) 

//FLORIDA
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==12, exposure(ln_pop) 

//GEORGIA
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==13, exposure(ln_pop) 

//OHIO
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==39, exposure(ln_pop) 

//OKLAHOMA 
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==40, exposure(ln_pop) 

//TENNESSEE
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==47, exposure(ln_pop) 

//TEXAS
nbreg sum_dp p_repub pnlb_0812 phsdged_0812 vcrimert cathrate pcthh_pafs_0812 if state_n==48, exposure(ln_pop) 

