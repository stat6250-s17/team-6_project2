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


* load external file that generates analytic dataset livingcost_combined;
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
"Based on the above output, there are top ten highest rent price of cities that are Hanoi, Caracas, Barcelona, Montevideo, Vancouver, Tampa, Seattle, San Francisco, San Diego."
;

footnote2
"Moreover, we can see that the top five to ten highest rent price of cities are the U.S. cities."
;

*
Note: This would involve average rent of cites, and then we can 
make a table to see the relationship.

Methodology: Use PROC PRINT to print just the first ten observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: This methodology does not account for cities with unknown
data, nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean values in order to filter out 
any possible illegal values, and better handle missing data
;

proc print
        noobs
        data= costliving_combined _temp(obs=10)
    ;
    id
        city_Name
    ;
    var
        Avg_rent
    ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Does the United States cities have a higher Avg_Disposable_Income than other country cities?'
;

title2
'Rationale: This indicates how the United States cities are different from the other country cities based on the disposable income.'
;

footnote1
"Based on the above output, we can see that all the five numbers (min,q1,median,q3,max) of the non United States cities are higher than the United States cities."
;

footnote2
"Moreover, the other country cities actually have a higher Avg_Disposable_Income than the United States cities."
;


*
Note: This would involve making either a chart to show the disposable income 
of the United States cities.

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
class 
    country;
    var
        Avg_Disposable_Income
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
"Moreover, we can see that the top two lowest crime rate of cities are Spain cities, and three cities are Germany."
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

proc print
        noobs
        data= costliving_combined _temp(obs=10)
    ;
    id
        city_Name
    ;
    var
        Crime_Rating
;
run;

title;
footnote;

