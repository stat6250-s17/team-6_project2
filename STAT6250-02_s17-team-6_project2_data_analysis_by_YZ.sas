*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Zillow Rent Index, the median estimated monthly rental 
price for a given area, and covers multifamily, single family, condominium, 
and cooperative homes in Zillow’s database, regardless of whether they are 
currently listed for rent. 
Dataset Name: frpm1415_analytic_file created in external file
STAT6250-02_s17-team-6_project2_data_preparation.sas, which is assumed to be
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
'Research question: Which metropolitan area is the most expensive to live in?'
;

title2
'Rational: We can have a rough idea of the range of the rent and the tendency of
house renting over the year.'
;

footnote1
"We can see that New York City is the most expensive to live in from the output."
;

footnote2
"We can conclude that Los Angels, San Francisco, Chicago are almost as expensive
as New York to live in."
;

footnote3
"We can see that there are several areas with extreme low rents that form as
outliers."
;

*
Note: This compares the column "Percent (%) Eligible Free (K-12)" from frpm1415
to the column of the same name from frpm1516.

Methodology: When combining frpm1415 with frpm1516 during data preparation,
take the difference of values of "Percent (%) Eligible Free (K-12)" for each
school and create a new variable called frpm_rate_change_2014_to_2015. Then,
use proc sort to create a temporary sorted table in descending by
frpm_rate_change_2014_to_2015. Finally, use proc print here to display the
first five rows of the sorted dataset.

Limitations: This methodology does not account for schools with missing data,
nor does it attempt to validate data in any way, like filtering for percentages
between 0 and 1.

Followup Steps: More carefully clean values in order to filter out any possible
illegal values, and better handle missing data, e.g., by using a previous year's
data or a rolling average of previous years' data as a proxy.
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
'Question: Which top 3 area rentals increase fastest in the past five years and 
which areas increase the lowest?'
;

title2
'Rational: We can then analysis the tendency of the house renting and know the 
relationship between the location and house rent price over the years, also get 
the overall graph of the rent.'
;

footnote1
"The house renting of Los Angels, New York and Chicago increase the fastest and
the house renting of Wichita, Aurora, Laredo increase the lowest. "
;

footnote2
"We can see that there are bunch of areas keeps increase in a gentle tendency."
;

footnote3
"There are some missing values that needed to be clean out."
;

*
Note: This compares the column "Percent (%) Eligible Free (K-12)" from frpm1415
to the column PCTGE1500 from sat15.

Methodology: Use proc means to compute 5-number summaries of "Percent (%)
Eligible Free (K-12)" and PCTGE1500. Then use proc format to create formats
that bin both columns with respect to the proc means output. Then use proc freq
to create a cross-tab of the two variables with respect to the created formats.

Limitations: Even though predictive modeling is specified in the research
questions, this methodology solely relies on a crude descriptive technique
by looking at correlations along quartile values, which could be too coarse a
method to find actual association between the variables.

Followup Steps: A possible follow-up to this approach could use an inferential
statistical technique like linear regression.
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


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Question: During which months or seasons do the house renting decrease overall 
according to the output?'
;

title2
'Rational: We can study the relationship between the location and the lowest rent 
over the year and observe the reason behind this changed/unchanged variables.'
;

footnote1
"Generally speaking, we can see that February, September and Novemember have the 
lowest house renting compared to the other months."
;

footnote2
"We can conclude that the months with most expensive house renting is August, January
and July."
;

footnote3
"There are some missing values in the xls, we need to clean out and run the code 
more precisely."
;

*
Note: This compares the column NUMTSTTAKR from sat15 to the column TOTAL from
gradaf15.

Methodology: When combining sat15 and gradaf15 during data preparation, take
the difference between NUMTSTTAKR in sat15 and TOTAL in gradaf15 for each
school and create a new variable called excess_sat_takers. Then, use proc sort
to create a temporary sorted table in descending by excess_sat_takers. Finally,
use proc print here to display the first 10 rows of the sorted dataset.

Limitations: This methodology does not account for schools with missing data,
nor does it attempt to validate data in any way, like filtering for values
outside of admissable values.

Followup Steps: More carefully clean the values of variables so that the
statistics computed do not include any possible illegal values, and better
handle missing data, e.g., by using a previous year's data or a rolling average
of previous years' data as a proxy.
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
