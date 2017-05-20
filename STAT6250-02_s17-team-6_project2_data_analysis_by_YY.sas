*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding college-preparation trends at CA public K-12 schools

Dataset Name: cde_2014_analytic_file created in external file
STAT6250-02_s17-team-0_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset cde_2014_analytic_file;
%include '.\STAT6250-02_s17-team-6_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What are the top five highest rent price of cities?' 
;

title2
'Rationale: This should help identify the highest rent price of cities. The rent price is the first thing that anyone who moves here will think about, because the rent is the largest proportion of people's cost. 
;

footnote1
"Of the five schools with the greatest increases in percent eligible for free/reduced-price meals between AY2014-15 and AY2015-16, the increase in percent eligible ranges from about 41% to about 55%."
;

footnote2
"Given the magnitude of these changes, further investigation should be performed to ensure no data errors are involved."
;

footnote3
"However, assuming there are no data issues underlying this analysis, possible explanations for such large increases include changing CA demographics and recent loosening of the rules under which students qualify for free/reduced-price meals."
;

Note: This would involve average rent of cites, and then we can 
make a table to see the relationship.


Methodology: 

Limitations: 

Followup Steps:
;

proc print
        data=cde_2014_analytic_file_sort_frpm(obs=5)
    ;
    id
        School_Name
    ;
    var
        frpm_rate_change_2014_to_2015
    ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Where does San Francisco rank in terms of cost of living?'
;

title2
'Rationale: We came to San Francisco Bay Area for study. We need to realize how much of living cost to pay. So, I want to know what level about cost in San Francisco to measure I can pay.'
;

footnote1
"As can be seen, there was an extremely high correlation between student poverty and SAT scores in AY2014-15, with lower-poverty schools much more likely to have high proportions of students with combined SAT scores exceeding 1500."
;

footnote2
"Possible explanations for this correlation include child-poverty rates tending to be higher at schools with lower overall academic performance and quality of instruction. In addition, students in non-poverish conditions are more likely to have parents able to pay for SAT preparation."
;

footnote3
"Given this apparent correlation based on descriptive methodology, further investigation should be performed using inferential methodology to determine the level of statistical significance of the result."
;

*
Note: This would involve making either a frequency chart to show 
the living cost in San Francisco.

Methodology: 

Limitations: 

Followup Steps:
;

proc freq
        data=cde_2014_analytic_file
    ;
    table
             Percent_Eligible_FRPM_K12
            *PCTGE1500
            / missing norow nocol nopercent
    ;
        where
            not(missing(PCTGE1500))
    ;
    format
        Percent_Eligible_FRPM_K12 Percent_Eligible_FRPM_K12_bins.
        PCTGE1500 PCTGE1500_bins.
    ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Which three of city have the lower crime rate?'
;
title2
"Rational: Low crime rate is good. The lower the score the safer people feel in this city. By the proportion of crime, we know which cities are more suitable for human habitation."
;

footnote1
"All ten schools listed appear to have extremely large numbers of 12th-graders graduating who have completed the SAT but not the coursework needed to apply for the UC/CSU system"
;

footnote2
"Given the magnitude of these numbers, further investigation should be performed to ensure no data errors are involved."
;

footnote3
"However, assuming there are no data issues underlying this analysis, possible explanations for such large numbers of 12th-graders completing only the SAT include lack of access to UC/CSU-preparatory coursework, as well as lack of proper counseling for students early enough in high school to complete all necessary coursework."
;

*
Note: This would involve the crime rate, and then we can make a table 
to see the relationship.

Methodology:

Limitations: 

Followup Steps:
;

proc print
        data=cde_2014_analytic_file_sort_sat(obs=10)
    ;
    id
        School_Name
    ;
    var
        excess_sat_takers
    ;
run;

title;
footnote;
