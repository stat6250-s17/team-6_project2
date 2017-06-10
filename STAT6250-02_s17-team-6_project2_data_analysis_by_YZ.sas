231 lines (175 sloc)  7.04 KB
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
'What are the Top 10 US Cities that have the highest house renting from 2015 to 2016?'
;

title2
'Provide the rough idea of which cities, metroes, counties and states that cost most living expense.'
;

footnote1
'Jupiter Island has the most expensive average rent from 2015-2016 at about $20,800 a month.'
;

footnote2
'The top five cities are located in Florida and California. These cities are not well-known but are located near well-known metropolitan areas like San Francisco, Los Angeles, and Miami. '
;

footnote3
'These cities are likely tiny, exclusive and highly expensive communities. A follow-up would be to look at the cities by the population ranking.'
;

*
Question: What are the top 10 most expensive US cities (present in house renting)
from year 2015 to 2016? Are the 5 least expensive US cities in terms of average rent 
price? 
Rationale: 
This will help identify cities where renting may be an issue due to high demand 
and low supply or the opposite. It will also show if there is any interesting 
geographic insights about cities with highest rent - such as 
coastal cities vs. inland cities.
Methodology: I will use PROC MEAN to calculate the mean of rent prices from 
Jan 2015 to Dec 2016 to proceed a new mean variable. Then using PROC SORT, I 
will sort the data and print only the top 5 cities by the mean variable.
Limitations: This output will take in account the average rent price over
a 2 year period. However, the trends could proceed additiona insights.
This will not show if rent has been declining in certain cities.
Followup Steps: Possible follow-up steps is to calculate change over month.
Or compare the average against the last month.
;

proc print
        data=rentprice_sorted(obs=5)
    ;
    id
        City Metro County State
    ;
    var
        average
    ;
run;

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Question: Which top 3 area obtain the house rent that increase fastest in the past five years in 2015? And does the result remain the same comparing to that of 2016?'
;

title2
'Rational: We can then analysis the tendency of the house renting and know the relationship between the location and house rent price over the years, also get the overall graph of the rent.'
;

footnote1
"The house renting of Los Angels, New York and Chicago increase the fastest and the house renting of Wichita, Aurora, Laredo increase the lowest. "
;

footnote2
"We can see that there are bunch of areas keeps increase in a gentle tendency."
;

footnote3
"There are some missing values that needed to be clean out."
;

*
Note: This compares the column "city" from rentprice2015
to the column city from rentprice2016. 

Methodology: Use proc means to compute 5-number summaries of house rent for
2015 and 2016. Then use proc format to create formatsthat bin both columns with 
respect to the proc means output. Then use proc freq to create a cross-tab 
of the two variables with respect to the created formats.

Limitations: Even though predictive modeling is specified in the research
questions, this methodology solely relies on a crude descriptive technique
by looking at correlations along quartile values, which could be too coarse a
method to find actual association between the variables.

Followup Steps: A possible follow-up to this approach could use an inferential
statistical technique like linear regression.
;

proc print
        data=rentprice_2015_analytic_file_sort_sat(obs=3)
    ;
    id
        City
    ;
    var
        Population
    ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Question: What are the top five areas that decrease most in rentprice for February comparing from 2015 to 2016?'
;

title2
'Rational: We can study the relationship between the location and the lowest rent over the year and observe the reason behind this changed/unchanged variables.'
;

footnote1
"Generally speaking, we can see that February, September and Novemember have the lowest house renting compared to the other months."
;

footnote2
"We can conclude that the months with most expensive house renting is August, January and July."
;

footnote3
"There are some missing values in the xls, we need to clean out and run the code more precisely."
;

*
Note: This compares the column for each month from rentprice15 to the column TOTAL
from rentprice16.

Methodology: When combining rentprice15 and rentpricef16 during data preparation, 
take the difference between house rent for each month in 2015 and TOTAL in 2016 for
each city and create a new variable called rentprice_rate_change. Then, use proc 
sort to create a temporary sorted table in descending by rentprice_rate_change. 
Finally, use proc print here to display the first 12 rows of the sorted dataset.

Limitations: This methodology does not account for each months' rents with missing 
data, nor does it attempt to validate data in any way, like filtering for values
outside of admissable values.

Followup Steps: More carefully clean the values of variables so that the
statistics computed do not include any possible illegal values, and better
handle missing data, e.g., by using a previous year's data or a rolling average
of previous years' data as a proxy.
;

proc print
        data=cde_2016_analytic_file_sort_frpm(obs=12)
    ;
    id
        City
    ;
    var
        rentprice_rate_change_2015_to_2016
    ;
run;

title;
footnote;
