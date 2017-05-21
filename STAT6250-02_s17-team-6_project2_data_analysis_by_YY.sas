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
'Research Question: What are the top ten the highest rent price of cities?' 
;

title2
'Rationale: This should help identify the highest rent price of cities. The rent price is the first thing that anyone who moves here will think about, because the rent would be the largest proportion of people's cost.'
;

footnote1
"Based on the above output, there are top ten highest rent price of cities that are Lausanne, Zurich, Geneva, Basel, Perth, Nashville, Canberra, Bergen, Luxembourg, Stavanger.'
;

footnote2
"Moreover, we can see that the top four highest rent price of cities are Swiss cities."
;
*
Note: This would involve average rent of cites, and then we can 
make a table to see the relationship.


Methodology: Use PROC SORT extract and sort the Average Rent from the dataset,
and output the results to a temporary dataset. Use PROC PRINT to print
the first ten observations from the temporary dataset.

Limitations: This methodology does not account for districts with unknown
data, nor does it attempt to validate data in any way.

Followup Steps: More carefully clean the values of the variable.
;
proc freq
        data=cde_2014_analytic_file
    ;
    table
        Avg_rent/ noprint out=Avg_rent_frequency;
run;
proc sort
        data=Avg_rent_frequency out=Avg_rent_sorted
    ;
    by
        descending count
    ;
run;
proc print
        noobs
        data=Avg_rent_sorted(obs=10)
    ;
run;
title;
footnote;



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Compare the cost of living in Beijing and San Francisco, which one is lower?'
;

title2
'Rationale: Beijing is my hometown city, but now I am living in San Francisco Bay Area for study. I want to know how much of living cost to pay in both of cities, and which one is lower.'
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
'Research Question: What are the top ten the lowest crime rate of cities?'
;
title2
"Rational: Low crime rate is good. Lower crime rate makes people feel more safer. By the proportion of crime, we know which cities are more suitable for human habitation."
;

footnote1
"Based on the above output, there are top ten lowest crime rate of cities that are "
;

footnote2
"Moreover, we can see that the top lowest crime rate of cities are Swiss cities."
*
Note: This would involve the crime rate, and then we can make a table 
to see the relationship.

Use PROC SORT extract and sort the Crime_Rating from the dataset,
and output the results to a temporary dataset. Use PROC PRINT to print
the first ten observations from the temporary dataset.

Limitations: This methodology does not account for districts with unknown
data, nor does it attempt to validate data in any way.

Followup Steps: More carefully clean the values of the variable.
;
proc freq
        data=cde_2014_analytic_file
    ;
    table
        Crime_Rating/ noprint out=Crime_Rating_frequency;
run;
proc sort
        data=Crime_Rating_frequency out=Crime_Rating_sorted
    ;
    by
        ascending count
    ;
run;
proc print
        noobs
        data=Crime_Rating_sorted(obs=10)
    ;
run;
title;
footnote;
