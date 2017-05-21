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
Note:

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
'Question: Where have rental prices increased in the past six years and where 
have they remained the same?'
;

title2
'Rational: We can then analysis the tendency of the house renting and know the 
relationship between the location and house rent price over the years, also get 
the overall graph of the rent.'
;

footnote1
"..............................."
;

footnote2
"..............................."
;

footnote3
"................................"
;

*
Note:

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


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Question: Which city or state has the lowest cost per square foot over the years? 
Have they changed?'
;

title2
'Rational: We can study the relationship between the location and the lowest rent 
over the year and observe the reason behind this changed/unchanged variables.'
;

footnote1
"................"
;

footnote2
".........."
;

footnote3
"....."
;

*
Note:

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
