
LIBNAME SDTM "/home/u64220165/SDTM";

proc import datafile="/home/u64220165/RAW/dm_raw_20250901_073302.csv"
    out=SDTM.DM
    dbms=csv
    replace;
    getnames=yes;
run;

proc import datafile="/home/u64220165/RAW/ex_raw_20250901_073302.csv"
    out=EX
    dbms=csv
    replace;
    getnames=yes;
run;

/* Step 1: Copy permanent DM1 into WORK */
data DM1;
    set SDTM.DM;
run;

/* Step 2: Make modifications in WORK */
data DM1;
    set DM1;
    STUDYID = strip(study_id);
    DOMAIN = "DM";
    SUBJID = strip(subject_id);
    SITEID = strip(site_number);
    USUBJID = strip(STUDYID)||"-"||strip(SITEID)||"-"||strip(SUBJID);
    
    
    RFSTDTC = put(enrollment_date,is8601da.); /* Create SDTM standard variable in ISO 8601 */
   	RFICDTC = put(informed_consent_date,is8601da.);
run;

data DM2;
    set DM1;
    AGE = age_years;   
    If AGE NE . then AGEU="YEARS";
    If gender NE "Female" then SEX="F";
    else SEX= "M";
    RACE = race_category;
    ETHNIC = ethnicity;
    COUNTRY = country_code;
    BRTHDTC = put(birth_date,is8601da.);
run;

data EX1;
    set EX;
    STUDYID = strip(study_id);
    DOMAIN = "DM";
    SUBJID = strip(subject_id);
    SITEID = strip(site_number);
    USUBJID = strip(STUDYID)||"-"||strip(SITEID)||"-"||strip(SUBJID);
    
    RFXSTDTC = put(administration_date,is8601da.)||"T"||put(administration_time,tod8.);
    If visit_name ="Period 1";
    If Drug NE 100 then TRT1="T1";
    else TRT1= "T2";
    length Treatment1 $6;
    If Drug NE 100 then Treatment1="50 mg";
    else Treatment1= "100 mg";
    Keep SUBJID RFXSTDTC TRT1 Treatment1;
run;



data EX2;
    set EX;
    STUDYID = strip(study_id);
    DOMAIN = "DM";
    SUBJID = strip(subject_id);
    SITEID = strip(site_number);
    USUBJID = strip(STUDYID)||"-"||strip(SITEID)||"-"||strip(SUBJID);
    
    RFXENDTC = put(administration_date,is8601da.)||"T"||put(administration_time,tod8.);
    If visit_name ="Period 2";
    If Drug NE 100 then TRT2="T1";
    else TRT2= "T2";
    length Treatment2 $6;
    If Drug NE 100 then Treatment2="50 mg";
    else Treatment2= "100 mg";
    Keep SUBJID RFXENDTC TRT2 Treatment2;
run;

proc sort data=EX1; by SUBJID; run;
proc sort data=EX2; by SUBJID; run;

data EX3;
Merge EX1 (IN=A) EX2 (IN=B);
by SUBJID;
If A or B;
run;

proc sort data=DM2; by SUBJID; run;

data DM3;
Merge DM2 (IN=A) EX3 (IN=B);
by SUBJID;
If A;
run;

Data DM4;
set DM3;
ARM = strip(Treatment1)||"-"||strip(Treatment2);
ARMCD = strip(TRT1)||"-"||strip(TRT2);
Keep
STUDYID
DOMAIN
USUBJID
SUBJID
RFSTDTC
RFXSTDTC
RFXENDTC
RFICDTC
SITEID
AGE
AGEU
SEX
RACE
ETHNIC
COUNTRY
ARM
ARMCD;
run;

proc freq data=DM4;
    tables ARMCD / nocum nopercent;
run;

/* Step 3: Save back to permanent SDTM */
data SDTM.DM1;
    set DM4;
run;


