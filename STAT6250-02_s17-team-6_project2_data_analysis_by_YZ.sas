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
'What are the top 10 cities over the country have the highest house renting from 2015 to 2016?'
;

title2
'Provide the rough idea of which cities, metroes, counties and states that cost the highest living expense.'
;

footnote1
'Based on the output, we claim that Jupiter Isaland, Atherton, Fisher Island,Belvedere, Hidden Hills are the top 10 expensive cities to live in that ranked from high to low.'
;

footnote2
'The areas obtaining the highest living expense located mostly in CA and FL, which is not surpurise to us by common sense becasue these states are always expensive. '
;

footnote3
'These cities are likely tiny, exclusive and highly expensive communities. A follow-up would be to look at the cities by the population ranking.'
;

*
Question: What are the top 10 most expensive US cities in house renting 
in year 2015 and 2016? Does the outcome surprise you?

Rationale: This will help identify cities where renting may be an issue due to high demand 
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
        data=rentprice_sorted(obs=10)
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


title1
'Average rent price for Top 10 cities with largest population'
;

proc print
        data=rentprice_sort2(obs=10)
    ;
    id
        City Metro County State Population_Rank
    ;
    var
	average
    ;
run;

title;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What are the top five states with the lowest crime rate?'
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
        data=Crime_Rating_sorted(obs=5)
    ;
    id
        State
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

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Which 5 cities have had the largest increase in rent prices from 2015 to 2016?'
;

title2
'This will help reveal economic trend for those cities - idenitfy which cities are on the rise.'
;

footnote1
'Three cities in the top 5 list are located in New York, one in California, and one in Florida. All 5 cities saw an increase of well over $1,000 in average rent prices between 2015 and 2016.'
;

footnote2
'The amount of increase in rent is really startling. A follow-up is to see what cities had a decrease in average rent price.'
;

*
Question: Which 5 cities have had the largest increase in rent prices from 
the two averages. Sort by the difference variable and print the top 5 cities.
Methodology: Use proc mean to calculate the average rent price for 2015 
and for 2016 separate. Then take the difference from 2016 and 2015. Use
proc sort to list the cities by the largest difference in rent prices 
between the average of 2015 and 2016.
Limitations: This only looks at increase of price. Looking at highest decrease
can also reveal interesting insights.
Followup Steps: Print the highest negative difference, not only the highest 
positive difference.
;

proc print
        data=rentprice_incr_2015_2016_sort(obs=5)
    ;
    id
        City Metro County State 
    ;
    var
	avg2015 avg2016 diffavg
    ;
run;

title;
footnote;

title1
'Top 5 cities with largest decrease in average rent from 2015 to 2016'
;


proc print
        data=rentprice_decr_2015_2016_sort(obs=10)
    ;
    id
        City Metro County State 
    ;
    var
	avg2015 avg2016 diffavg
    ;
run;

title;
