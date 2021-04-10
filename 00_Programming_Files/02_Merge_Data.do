clear
set more off

//SET WORKING DIRECTORY//
*****************************
global fileloc "set_your_file_path_here"

//ACS COUNTY-LEVEL 2008 TO 2012 ESTIMATES //
*******************************************
use "$fileloc\02_Prepped_Data\ACS0812_050_Final.dta"

//DEATH PENALTY USAGE DATA//
****************************
merge 1:1 state county using  "$fileloc\County_Level_Death_Penalty_1214.dta"
drop _merge
replace death_sen=0 if death_sent==.
replace execution=0 if execution==.

//UCR CRIME DATA//
*******************
merge 1:1 state_n county_n using  "$fileloc\UCR_Crimes_2012.dta"
drop if _merge==2
drop _merge

//ARDA RELIGION DATA//
************************
merge 1:1 state_n county_n using  "$fileloc\County_Religion_Data_2010.dta"
list cntyname if _merge==2
drop if _merge==2
drop _merge

//Assuming that if data is missing, rate of adherents is ZERO//
replace totrate=0 if totrate==.
replace evanrate=0 if evanrate ==.
replace bprtrate =0 if bprtrate ==.
replace mprtrate =0 if mprtrate ==.
replace cathrate =0 if cathrate ==.
replace orthrate =0 if orthrate   ==.
replace cthrate=0 if cthrate ==.

//GUARDIAN ELECTION VOTING DATA//
*********************************
gen fips=state+county
destring fips, gen(fips_n)
merge 1:1 fips_n using  "$fileloc\County_Voting_Data_2012.dta"
list state name if _merge==1
drop if _merge==2
drop _merge

//BJS INCARCERATION DATA//
****************************
merge m:1 state_n using  "$fileloc\State_Incarceration_Data_1213.dta"
drop if _merge==2
drop _merge

//Indicator of Death Penalty State//
//These states do legally use DP//
*************************************
replace stab=strupper(stab)
gen st_dp=0
label var st_dp "State Indicator of Death Penalty"
replace st_dp=1 if stab=="AL"
replace st_dp=1 if stab=="AZ"
replace st_dp=1 if stab=="AR"
replace st_dp=1 if stab=="CA"
replace st_dp=1 if stab=="CO"
replace st_dp=1 if stab=="DE"
replace st_dp=1 if stab=="FL"
replace st_dp=1 if stab=="GA"
replace st_dp=1 if stab=="ID"
replace st_dp=1 if stab=="IN"
replace st_dp=1 if stab=="KS"
replace st_dp=1 if stab=="KY"
replace st_dp=1 if stab=="LA"
replace st_dp=1 if stab=="MS"
replace st_dp=1 if stab=="MO"
replace st_dp=1 if stab=="MT"
replace st_dp=1 if stab=="NE"
replace st_dp=1 if stab=="NV"
replace st_dp=1 if stab=="NH"
replace st_dp=1 if stab=="NC"
replace st_dp=1 if stab=="OH"
replace st_dp=1 if stab=="OK"
replace st_dp=1 if stab=="OR"
replace st_dp=1 if stab=="PA"
replace st_dp=1 if stab=="SC"
replace st_dp=1 if stab=="SD"
replace st_dp=1 if stab=="TN"
replace st_dp=1 if stab=="TX"
replace st_dp=1 if stab=="UT"
replace st_dp=1 if stab=="VA"
replace st_dp=1 if stab=="WA"
replace st_dp=1 if stab=="WY"

//ORDER VARIABLES//
order geoid state state_n county county_n fips fips_n stab name st_dp death_sentence execution vcrime p_repub ///
totrate evanrate bprtrate mprtrate cathrate orthrate cthrate incar2012 mincar2012 fincar2012 incar2013 mincar2013 fincar2013


//LABEL VARIABLES//
label var fips "County FIPS Code-String"
label var fips_n "County FIPS Code-Numeric"
label var incar2012 "Incarceration Rate 2012"
label var mincar2012  "Male Incarceration Rate 2012"
label var fincar2012 "Female Incarceration Rate 2012"
label var incar2013 "Incarceration Rate 2013"
label var mincar2013 "Male Incarceration Rate 2013"
label var fincar2013 "Female Incarceration Rate 2013"


//SAVE ANALYTIC FILE//
savespss "$fileloc\Death_Penalty_Data_Final_For_MA_Thesis.dta", replace




