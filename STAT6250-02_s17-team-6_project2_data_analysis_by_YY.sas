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

Dataset Name: _analytic_file created in external file
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
'Research Question: What are the top ten the highest rent price of cities?' 
;

title2
'Rationale: This should help identify the highest rent price of cities. The rent price is the first thing that anyone who moves here will think about, because the rent would be the largest proportion of people's cost.'
;

footnote1
"Based on the above output, there are top ten highest rent price of cities that are Hanoi, Caracas, Barcelona, Montevideo, Vancouver, Tampa, Seattle, San Francisco, San Diego.'
;

footnote2
"Moreover, we can see that the top five to ten highest rent price of cities are the U.S. cities."
;

*
Note: This would involve average rent of cites, and then we can 
make a table to see the relationship.

Methodology: Use PROC SORT extract and sort the Average Rent from the dataset,
and output the results to a temporary dataset. Use PROC PRINT to print
the first ten observations from the temporary dataset.

Limitations: This methodology does not account for cities with unknown
data, nor does it attempt to validate data in any way.

Possible Followup Steps: More carefully clean values in order to filter out 
any possible illegal values, and better handle missing data
;

proc freq
        data=costliving_combined
    ;
    table
        Avg_rent/ noprint out=Avg_rent_frequency;
run;
proc sort
        data=Avg_rent_frequency out=Avg_rent_sorted
    ;
    by
        descending Avg_Rent
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
"As can be seen, there are the cost of living in Beijing and San Francisco."
;

footnote2
"the average disposable income in San Francisco is higher than Beijing."
;

*
Note: This would involve making either a frequency chart to show 
the living cost in San Francisco and Beijing.

Methodology:Compute five-number summaries by Avg Disposable Income from the
dataset, and output the results to a temporary dataset. Use PROC PRINT to
print the Beijing and San Francesco observations from the temporary dataset.

Limitations: This problem is straight forward, the only draw-back would be if
the Avg Disposable Income category is not given so we can not sort them properly.

Possible Follow-up Steps: A possible follow-up to this approach could use 
an inferential statistical technique like linear regression.
;

proc means
        min q1 median q3 max
        data=costliving_combined
    var
        Avg_Disposable_Income
    ;
run;
proc freq
        data=homicide_analytic_file
    ;
    table
        city*Avg_Disposable_Income/norow nocol nopercent;
    format 
        Avg_Disposable_Income Avg_Disposable_Income_bin.
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
"Based on the above output, there are top ten lowest crime rate of cities that are Malaga, Marbella, Abu Dhabi, Tokyo, Aachen, Dresden, Dusseldorf, Zurich, Taipei, Hong Kong."
;

footnote2
"Moreover, we can see that the top two lowest crime rate of cities are Spain cities."
;

*
Note: This would involve the crime rate, and then we can make a table 
to see the relationship.

Methodology: Use PROC PRINT to print the first ten observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: This methodology does not account for cities with missing data,
nor does it attempt to validate data in any way.

Possible Follow-up Steps:  More carefully clean values in order to filter out 
any possible illegal values, and better handle missing data.
;

proc freq
        data=costliving_combined
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
