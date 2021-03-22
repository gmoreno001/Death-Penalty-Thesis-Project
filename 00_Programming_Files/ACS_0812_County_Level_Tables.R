# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# THIS FILE EXTRACTS ALL THE NECESSARY ACS 2008-2012 COUNTY-LEVEL 
# 5 YEAR ESTIMATES AND CREATES SOCIO-DEMOGRAPHICS VARIABLES FOR ANALYSIS 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# STEPS:
# ~~~~~~
# 1. Request a Census API Key here: https://api.census.gov/data/key_signup.html
# 2. Confirm your key via the link emailed to you (try a few minutes later if you get an error)
# 3. Un-comment the line with the census_api_key() function. Insert your key and run the code 
#     through that point once. Then you can re-comment or delete that line.
# 4. Update analysis_state and analysis_county to the ones you are interested in and run the rest of the code.

# NOTES:
# ~~~~~~
# get_decennial(), which grants access to the 2000 and 2010 decennial US Census APIs
# get_acs(), which grants access to the 1-year and 5-year American Community Survey APIs

# SOURCE: 
# ~~~~~~
# https://github.com/dunham-mike/suburbs/blob/master/tidycensus%20-%20retrieve%20household%20income%20by%20race%20%26%20ethnicity%20for%20a%20county.R

# CLEAR ENVIRONMENT
rm(list = ls())

#install.packages("tidycensus")
library(tidycensus)
library(tidyverse)

census_api_key("your_census_key", overwrite =TRUE) 
#readRenviron("~/.Renviron")

# EXTRACT TABLES NEEDED FOR ANALYSIS 
all_vars <- get_acs(geography = "county", year = 2012,
                    variables = c(
                      
                      # AGE AND GENDER 
                      "B01001_001", "B01001_006", "B01001_007", "B01001_008", "B01001_009", "B01001_010", "B01001_011", "B01001_012",
                      "B01001_013", "B01001_014", "B01001_015", "B01001_016", "B01001_017", "B01001_018", "B01001_019", "B01001_020",
                      "B01001_021", "B01001_022", "B01001_023", "B01001_024", "B01001_025", "B01001_030", "B01001_031", "B01001_032", 
                      "B01001_033", "B01001_034", "B01001_035", "B01001_036", "B01001_037", "B01001_038", "B01001_039", "B01001_040",
                      "B01001_041", "B01001_042", "B01001_043", "B01001_044", "B01001_045", "B01001_046", "B01001_047", "B01001_048", "B01001_049",
                      
                      # RACE 
                      "B01001_001", "B03002_013", "B03002_003", "B03002_014", "B03002_004", "B03002_012",
                      
                      # FOREIGN BORN, RESIDENCE - MIGRATION
                      "B01001_001", "B05002_013", "B07001_001", "B07001_017",
                      
                      # HOUSEHOLDS - FAMILIES
                      "B11001_001", "B11001_006", "B11003_001", "B11003_016", "B12001_001", "B12001_010", "B12001_019",
                      
                      # EDUCATION 
                      "B15003_001", "B15003_017", "B15003_018", "B15003_021", "B15003_022", "B15003_023", "B15003_024", "B15003_025",
                      
                      # POVERTY 
                      "B11003_001", "B17001_001", "B17001_003", "B17001_017", "B17001_032", "B17001_046", "B17010_002", "B17010_022",
                      
                      # HOUSEHOLD INCOME 
                      "B19001_001", "B19001_002", "B19001_003", "B19001_004", "B19001_005", "B19001_006", "B19001_007", "B19001_008",
                      "B19001_009", "B19001_010", "B19001_011", "B19001_012", "B19001_013", "B19001_014", "B19001_015", "B19001_016",
                      "B19001_017", "B19013_001",
                      
                      # PUBLIC ASSISTANCE 
                      "B19001_001", "B19057_002", "B19057_003", "B19058_002", "B19058_003", "B19101_001",
                      
                      # FAMILY INCOME 
                      "B19101_002", "B19101_003", "B19101_004", "B19101_005", "B19101_006", "B19101_007", "B19101_008", "B19101_009",
                      "B19101_010", "B19101_011", "B19101_012", "B19101_013", "B19101_014", "B19101_015", "B19101_016", "B19101_017",
                      "B19113_001",
                      
                      # LABOR FORCE AND EMPLOYMENT <tot_16over_clf> 
                      "B23001_006", "B23001_013", "B23001_020", "B23001_027", "B23001_034", "B23001_041", "B23001_048", "B23001_055",
                      "B23001_062", "B23001_069", "B23001_074", "B23001_079", "B23001_084", "B23001_092", "B23001_099", "B23001_106",
                      "B23001_113", "B23001_120", "B23001_127", "B23001_134", "B23001_141", "B23001_148", "B23001_155", "B23001_160",
                      "B23001_165", "B23001_170",
                      
                      # LABOR FORCE AND EMPLOYMENT <tot_16over_clf_unemp>
                      "B23001_008", "B23001_015", "B23001_022", "B23001_029", "B23001_036", "B23001_043", "B23001_050", "B23001_057",
                      "B23001_064", "B23001_071", "B23001_076", "B23001_081", "B23001_086", "B23001_094", "B23001_101", "B23001_108", 
                      "B23001_115", "B23001_122", "B23001_129", "B23001_136", "B23001_143", "B23001_150", "B23001_157", "B23001_162",
                      "B23001_167", "B23001_172",
                      
                      # TOTAL POPULATION 16-64 IN THE ARMED FORCES
                      "B23001_005", "B23001_012", "B23001_019", "B23001_026", "B23001_033", "B23001_040", "B23001_047", "B23001_054", 
                      "B23001_061", "B23001_068", "B23001_091", "B23001_098", "B23001_105", "B23001_112", "B23001_119", "B23001_126",
                      "B23001_133", "B23001_140", "B23001_147", "B23001_154",
                      
                      # TOTAL POPULATION 16-64 NOT IN THE LABOR FORCE
                      "B23001_009", "B23001_016", "B23001_023", "B23001_030", "B23001_037", "B23001_044", "B23001_051", "B23001_058",
                      "B23001_065", "B23001_072", "B23001_095", "B23001_102", "B23001_109", "B23001_116", "B23001_123", "B23001_130",
                      "B23001_137", "B23001_144", "B23001_151", "B23001_158",
                      
                      # TOTAL POPULATION 16-64
                      "B23001_003", "B23001_010", "B23001_017", "B23001_024", "B23001_031", "B23001_038", "B23001_045", "B23001_052",
                      "B23001_059", "B23001_066", "B23001_089", "B23001_096", "B23001_103", "B23001_110", "B23001_117", "B23001_124",
                      "B23001_131", "B23001_138", "B23001_145", "B23001_152",
                      
                      # HOUSING
                      "B25002_001", "B25002_002", "B25003_002", "B25003_003", "B25002_003", "B25004_004", "B25004_006", "B25004_007"))

# PREP DATA BEFORE CREATING VARIABLES 
all_vars1 <- all_vars %>% 
  # removes Puerto Rico counties
  filter(!(str_detect(NAME, "Puerto Rico"))) %>%  
  # removes margin of error variable
  select(-moe) %>%  
  # reshapes from long to wide so each ACS table is a column now and each row is a county
  pivot_wider(names_from=variable, values_from=estimate)  
            
        
# AGE AND GENDER  -----------------------------------------------
age_gender <- all_vars1 %>%
  rename(
    totalpop_0812 = B01001_001) %>%
  mutate(
    malepop1524_0812 = (B01001_006 + B01001_007 + B01001_008 + B01001_009 + B01001_010),
    malepop1529_0812 = (malepop1524_0812 + B01001_011),
    fmalepop1524_0812 = (B01001_030  + B01001_031 + B01001_032 + B01001_033 + B01001_034),
    fmalepop1529_0812 = fmalepop1524_0812 + B01001_035,
    pop1524_0812 = malepop1524_0812 + fmalepop1524_0812,
    pop1529_0812 = malepop1529_0812 + fmalepop1529_0812,
    popover15_0812 = (B01001_012  + B01001_013 + B01001_014 + B01001_015 + B01001_016 + 
                        B01001_017 + B01001_018 + B01001_019 + B01001_020 + 
                        B01001_021 + B01001_022 + B01001_023 + B01001_024 + 
                        B01001_025 + B01001_036 + B01001_037 + B01001_038 + 
                        B01001_039 + B01001_040 + B01001_041 + B01001_042 + 
                        B01001_043 + B01001_044 + B01001_045 + B01001_046 + 
                        B01001_047 + B01001_048 + B01001_049),
    p1524_0812 = (pop1524_0812/totalpop_0812)*100,
    p1529_0812 = (pop1529_0812/totalpop_0812)*100) %>%
  select(-starts_with("B"))


# RACE  -----------------------------------------------
race <- all_vars1 %>%
  rename(
    totalpop_0812 = B01001_001,
    whitelatpop_0812 = B03002_013,
    nlwhitepop_0812 = B03002_003,
    blklatpop_0812 = B03002_014,
    nlblkpop_0812 = B03002_004,
    latpop_0812 = B03002_012) %>%
  mutate(
    pnlb_0812 = (nlblkpop_0812/totalpop_0812)*100,
    plat_0812 = (latpop_0812/totalpop_0812)*100) %>%
  select(-starts_with("B",ignore.case = FALSE)) #if we don't specify this <blklatpop_0812> will be dropped 


# FOREIGN BORN, RESIDENCE - MIGRATION  -----------------------------------------------
fborn_resid <- all_vars1 %>% 
  rename(
    totalpop_0812 = B01001_001,
    fbornpop_0812 = B05002_013,
    popover1_0812 = B07001_001,
    samehhpop_0812 = B07001_017) %>%
  mutate(
    pctfborn_0812 = (fbornpop_0812/totalpop_0812)*100,
    pct_samehh1yr_0812 = (samehhpop_0812/popover1_0812)*100) %>%
  select(-starts_with("B"))


# HOUSEHOLDS - FAMILIES  -----------------------------------------------
hhold_fam <- all_vars1 %>%
  rename(
    tot_hh_0812 = B11001_001,
    femhh_0812 = B11001_006,
    totfam_0812 = B11003_001,
    femfamk_0812 = B11003_016,
    popovr15_0812 = B12001_001) %>%
  mutate(
    pfemhh_0812 = (femhh_0812/tot_hh_0812)*100,
    pctfemfamk_0812 = (femfamk_0812/totfam_0812)*100,
    popdivc_0812 = B12001_010 + B12001_019,
    pctdivc_0812 = (popdivc_0812/popovr15_0812)*100) %>%
  select(-starts_with("B"))

# EDUCATION  -----------------------------------------------
education <- all_vars1 %>%
  rename(
    popovr25_0812 = B15003_001) %>%
  mutate(
    phsd_0812 = (B15003_017/popovr25_0812)*100,
    phsdged_0812 = ((B15003_017 + B15003_018)/popovr25_0812)*100,
    passoc_0812 = (B15003_021/popovr25_0812)*100,
    pbach_0812 = (B15003_022/popovr25_0812)*100,
    pmast_0812 = (B15003_023/popovr25_0812)*100,
    pdocpro_0812 = ((B15003_024 + B15003_025)/popovr25_0812)*100) %>%
  select(-starts_with("B"))


# POVERTY  -----------------------------------------------
poverty <- all_vars1 %>%
  rename(
    totfam_0812 = B11003_001,
    poppovdet_0812 = B17001_001,
    fambelpov_0812 = B17010_002,
    famabvpov_0812 = B17010_022) %>%
  mutate(
    popbelpov_0812 = B17001_003 + B17001_017,
    popabvpov_0812 = B17001_032 + B17001_046,
    pctbelpov_0812 = (popbelpov_0812/poppovdet_0812)*100,
    pctabvpov_0812 = (popabvpov_0812/poppovdet_0812)*100,
    pctfambelpov_0812 = (fambelpov_0812/totfam_0812)*100,
    pctfamabvpov_0812 = (famabvpov_0812/totfam_0812)*100) %>%
  select(-starts_with("B"))


# HOUSEHOLD INCOME  -----------------------------------------------
hhold_income <- all_vars1 %>%
  rename(
    tot_hh_0812 = B19001_001,
    hh_Less10k_0812 = B19001_002,
    hh_10k_15k_0812 = B19001_003,
    hh_15k_20k_0812 = B19001_004,
    hh_20k_25k_0812 = B19001_005,
    hh_25k_30k_0812 = B19001_006,
    hh_30k_35k_0812 = B19001_007,
    hh_35k_40k_0812 = B19001_008,
    hh_40k_45k_0812 = B19001_009,
    hh_45k_50k_0812 = B19001_010,
    hh_50k_60k_0812 = B19001_011,
    hh_60k_75k_0812 = B19001_012,
    hh_75k_100k_0812 = B19001_013,
    hh_100k_125k_0812 = B19001_014,
    hh_125k_150k_0812 = B19001_015,
    hh_150k_200k_0812 = B19001_016,
    hh_Greater200k_0812 = B19001_017,
    medhhinc_0812 = B19013_001) %>%
  select(-starts_with("B"))


# PUBLIC ASSISTANCE  -----------------------------------------------
pub_asst <- all_vars1 %>%
  rename(
    tot_hh_0812 = B19001_001,
    hh_pa_0812 = B19057_002,
    hh_nopa_0812 = B19057_003,
    hh_pafs_0812 = B19058_002,
    hh_nopafs_0812 = B19058_003) %>%
  mutate(
    pcthh_pa_0812 = (hh_pa_0812/tot_hh_0812)*100,
    pcthh_pafs_0812 = (hh_pafs_0812/tot_hh_0812)*100) %>%
  select(-starts_with("B"))

# FAMILY INCOME  -----------------------------------------------
fam_inc <- all_vars1 %>%
  rename(fam_Less10k_0812 = B19101_002,
         fam_10k_15k_0812 = B19101_003,
         fam_15k_20k_0812 = B19101_004,
         fam_20k_25k_0812 = B19101_005,
         fam_25k_30k_0812 = B19101_006,
         fam_30k_35k_0812 = B19101_007,
         fam_35k_40k_0812 = B19101_008,
         fam_40k_45k_0812 = B19101_009,
         fam_45k_50k_0812 = B19101_010,
         fam_50k_60k_0812 = B19101_011,
         fam_60k_75k_0812 = B19101_012,
         fam_75k_100k_0812 = B19101_013,
         fam_100k_125k_0812 = B19101_014,
         fam_125k_150k_0812 = B19101_015,
         fam_150k_200k_0812 = B19101_016,
         fam_Greater200k_0812 = B19101_017,
         medfaminc_0812 = B19113_001) %>%
  select(-starts_with("B"))


# LABOR FORCE AND EMPLOYMENT -----------------------------------------------

lf_unemployment <- all_vars1 %>%
  mutate(
    tot_16ovr_clf_0812 = (B23001_006 + B23001_013 + B23001_020 + B23001_027 + B23001_034 + B23001_041 + B23001_048 + 
    B23001_055 + B23001_062 + B23001_069 + B23001_074 + B23001_079 + B23001_084 + B23001_092 + 
    B23001_099 + B23001_106 + B23001_113 + B23001_120 + B23001_127 + B23001_134 + B23001_141 + 
    B23001_148 + B23001_155 + B23001_160 + B23001_165 + B23001_170),
    tot_1664_clf_0812 = (B23001_006 + B23001_013 + B23001_020 + B23001_027+B23001_034 + B23001_041 + B23001_048 +
    B23001_055 + B23001_062 + B23001_069 + B23001_092 + B23001_099 + B23001_106 + B23001_113 + B23001_120 +
    B23001_127 + B23001_134 + B23001_141 + B23001_148 + B23001_155),
    tot_16ovr_clf_unemp_0812 = (B23001_008  + B23001_015 + B23001_022 + B23001_029 + B23001_036 + B23001_043 + 
                                  B23001_050 + B23001_057 + B23001_064 + B23001_071 + B23001_076 + B23001_081 + 
                                  B23001_086 + B23001_094 + B23001_101 + B23001_108 + B23001_115 + B23001_122 + 
                                  B23001_129 + B23001_136 + B23001_143 + B23001_150 + B23001_157 + B23001_162 + 
                                  B23001_167 + B23001_172),
    tot_1664_clf_unemp_0812 = (B23001_008 + B23001_015 + B23001_022 + B23001_029 + B23001_036 + B23001_043 + 
                                 B23001_050 + B23001_057 + B23001_064 + B23001_071 + B23001_094 + B23001_101 + 
                                 B23001_108 + B23001_115 + B23001_122 + B23001_129 + B23001_136 + B23001_143 + 
                                 B23001_150 + B23001_157),
    pct_16ovr_clf_unemp_0812 = (tot_16ovr_clf_unemp_0812/tot_16ovr_clf_0812)*100,
    pct_1664_clf_unemp_0812 = (tot_1664_clf_unemp_0812/tot_1664_clf_0812)*100) %>%
  select(-starts_with("B"))

# NOT IN LABOR FORCE -----------------------------------------------

pop_notinlf <- all_vars1 %>%
  mutate(
    tot_1664_armforc_0812 = (B23001_005 + B23001_012 + B23001_019 + B23001_026 + B23001_033 + B23001_040 + 
                               B23001_047 + B23001_054 + B23001_061 + B23001_068 + B23001_112 + B23001_119 + 
                               B23001_126 + B23001_133 + B23001_140 + B23001_147 + B23001_154),
    tot_1664_notinlf_0812 = (B23001_009 + B23001_016 + B23001_023 + B23001_030 + B23001_037 + B23001_044 + 
                               B23001_051 + B23001_058 + B23001_065 + B23001_072 + B23001_116 + B23001_123 + 
                               B23001_130 + B23001_137 + B23001_144 + B23001_151 + B23001_158),
    tot_pop_1664_0812 = (B23001_003 + B23001_010 + B23001_017 + B23001_024 + B23001_031 + B23001_038 + 
                           B23001_045 + B23001_052 + B23001_059 + B23001_066 + B23001_110 + B23001_117 + 
                           B23001_124 + B23001_131 + B23001_138 + B23001_145 + B23001_152),
    pct_1664_civ_notinlf = (tot_1664_notinlf_0812/(tot_pop_1664_0812 - tot_1664_armforc_0812))*100) %>%
  select(-starts_with("B"))


# HOUSING  -----------------------------------------------

housing <- all_vars1 %>%
  rename(
    tot_hu_0812 = B25002_001,
    hu_occ_0812 = B25002_002,
    ohu_ownocc_0812 = B25003_002,
    ohu_rentocc_0812 = B25003_003,
    hu_vac_0812 = B25002_003,
    vhu_fso = B25004_004,
    vhu_sro = B25004_006,
    vhu_fmw = B25004_007) %>%
  mutate(
    pct_hu_occ_0812 = (hu_occ_0812/tot_hu_0812)*100,
    pct_hu_vac_0812 = (hu_vac_0812/tot_hu_0812)*100,
    prent_0812 = (ohu_rentocc_0812/ hu_occ_0812)*100,
    pct_ownocchunits_0812 = (ohu_ownocc_0812/tot_hu_0812)*100) %>%
  select(-starts_with("B"))


# COMBINE DATA FRAMES  -----------------------------------------------

# Store all data frames in a list 
acs_list <- list(age_gender, race, fborn_resid, hhold_fam, education, poverty, hhold_income, 
                 pub_asst, fam_inc, lf_unemployment, pop_notinlf, housing)    

# Combine all data frames by GEOID and [COUNTY] NAME
acs_df <- acs_list %>% reduce(full_join, by=c("GEOID", "NAME")) 

# Remove duplicated vars and rename as necessary 
acs_df <- acs_df %>% 
  select(-totalpop_0812.x, -totalpop_0812.y, -totfam_0812.y, -tot_hh_0812.x, -tot_hh_0812.y) %>%
  rename(totfam_0812 = totfam_0812.x)

# Split GEOID into state and county 
acs_df$state <- substring(acs_df$GEOID,1,2)
acs_df$county <- substring(acs_df$GEOID,3,5)

# Order variables 
acs_df <- acs_df %>% relocate(GEOID, state, county)

# SAVE OUT FILE 
write_dta(acs_df, "set_your_file_path_here/02_Prepped_Data/ACS0812_050_Final.dta", version = 12)


