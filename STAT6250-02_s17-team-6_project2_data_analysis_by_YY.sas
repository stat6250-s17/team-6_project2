*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding rental prices and living cost trends at in the US.

Dataset Name: rentprice_combined and livingcost_combined created in 
external file STAT6250-02_s17-team-6_project2_data_preparation.sas, which is 
assumed to be in the same directory as this file

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
'Rationale: This should help identify the highest rent price of cities. The rent price is the first thing that most people who need to move to another city to consider, because the rent would be the largest proportion of living cost.'
;

footnote1
"Based on the above output, there are ten cities with the highest rent, that are Hong Kong(China), New York(United States), Singapore(Singapore), Sydney(Australia), Geneva(Switzerland), London(United Kingdom), San Francisco(United States), Washington(United Kingdom), Zurich(Germany), Brisbane(Australia)."
;

footnote2
"We can see that there are two American cities, two British cities and two Australian cities in the top ten highest rent list."
;

footnote3
"Moreover, the ten cities are economically well developed cities, San Francisco ranked seventh, it led the economic development of the Bay Area."
;

*
Note: This would involve average rent of cites, and then we can 
make a table to see the relationship.

Methodology: Use PROC PRINT to print just the first ten observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: This methodology does not show the names of country,
nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean values in order to filter out 
any possible illegal values, and better handle missing data.
;

proc print
        data=Avg_Rent_sorted(obs=10)
    ;
    id
        city
    ;
    var
        Avg_rent
    ;
run;

proc means 
        data=Avg_Rent_sorted
    ;
    var
	Avg_Rent
    ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Do the United States cities have a higher Avg_Disposable_Income than other country cities?'
;

title2
'Rationale: This indicates how the United States cities are different from the other country cities based on the disposable income.'
;

footnote1
"Based on the above output, we can see that all the five numbers(min, q1, median, q3, max), and the IQR."
;

footnote2
"All of the United States are in the Q3 and Q4 Avg_Disposable_Income levels."
;

footnote3
"Moreover, the United States cities actually have a higher Avg_Disposable_Income than others."
;


*
Note: This would involve making either a chart to show levels of disposable
income of the United States cities.

Methodology: Use Proc Format to categorize the variable "country" into two 
groups, "USA" and "Not_USA". Use a data procedure to associate the new format 
with the variable "country", and store into a new dataset. Compute five-number
summaries by Avg_Disposable_Income from the dataset, and output the results
to a temporary dataset. 

Limitations: This problem is straight forward, the only draw-back would be
if the Avg Disposable Income category is not given so we can not sort them
properly.

Possible Follow-up Steps: A possible follow-up to this approach could use 
an inferential statistical technique like linear regression.
;

proc means 
        min q1 median q3 max 
        data=costliving_combined
    ;
    var
        Avg_Disposable_Income
    ;
	output out=disposable_income_summary
    ;
run;

proc freq 
        data=disposable_income_analysis
    ;
    table 
        country*avg_disposable_income / missing norow nocol nopercent;
    format 
        country $country_bins.
	avg_disposable_income avg_disposable_income_bins.
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
'Rationale: Low crime rate is good. Lower crime rate give people more sense of security. By the crime rate, we know which cities are safer and suitable for human habitation.'
;

footnote1
"Based on the above output, there are top ten lowest crime rate of cities that are Malaga(Spain), Marbella(Spain), Abu Dhabi(United Arab Emirates), Tokyo(Japan), Aachen(Germany), Dresden(Germany), Dusseldorf(Germany), Munich(Germany), Zurich(Germany), Taipei(Taiwan)."
;

footnote2
"Also, we can see that the first and second cities are Spanish cities, and there are five German cities(fifth to ninth) in the top ten list."
;

footnote3
"Moreover, The top ten cities have much lower crime rates than average, so they are relatively safe cities."
;


*
Note: This would involve the crime rate, and then we can make a table 
to see the relationship.

Methodology: Use PROC PRINT to print the first ten observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: This methodology does not show the names of country,
nor does it attempt to validate data in any way.

Possible Follow-up Steps:  More carefully clean values in order to filter out 
any possible illegal values, and better handle missing data.
;

proc print
        data=Crime_Rating_sorted(obs=10)
    ;
    id
        City
    ;
    var
        Crime_Rating
    ;
run;

proc means data=Crime_Rating_sorted;
	var
		Crime_Rating
	;
run;

title;
footnote;

