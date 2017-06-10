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
'Some of these cities names sound like small islands that are not familar to me, but all of them locate near huge cities with large population.'
;

*
Question: What are the top 10 most expensive US cities in house renting 
in year 2015 and 2016? Does the outcome surprise you?

Rationale: This will help identify cities where renting may be an issue due to high demand 
and low supply or the opposite. It will also show if there is any interesting 
geographic insights about cities with highest rent - such as 
coastal cities vs. inland cities.

Methodology: I will use PROC MEAN to calculate the mean of rent prices from 
Jan 2015 to Dec 2016 to proceed a new mean variable. By using PROC SORT,
the top 10 expensive cities will be sorted and print by the mean variable.

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
'Research Question: What are the top five cities with the lowest crime rate?'
;

title2
'Rationale: Provide the top5 safest cities for living.'
;

footnote1
"Based on the output, the are top five cities with the lowest crime rate are Malaga, Marbella, Abu Dhabi, Tokyo and Aachen."
;

footnote2
"The safest cities are locate in Spain, German and Tokyo."
;

footnote3
"Also, these safe places are also not cheap to live."
;


*
Note: This research question could provide a rough idea of which cities
are most suitable for living based on the factor of safety.

Methodology: Use PROC PRINT to print the first five observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: This methodology does not deal with the missing values.

Possible Follow-up Steps:  More carefully clean out missing values or
deal with the unnecessary columns for our prediction.
;

proc print
        data=Crime_Rating_sorted(obs=5)
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

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Which ten cities have the largest increase in house renting from 2015 to 2016?'
;

title2
'Provide the house renting tendency in these ten cities.'
;

footnote1
'Most cities that obtaining a sharp increase in house renting located in California and New York, which is reasonble and predictable for us.'
;

footnote2
'The increased house renting in these cities are quite large, more investigate should be applied to see what factors cause this phenomenon.'
;

footnote3
'Also evaluate the top 10 cities that decrease most in house renting from 2015 to 2016, check the output to see if it is reasonable.'
;

*
Question: Which ten cities have the largest increase in house renting from 
the two averages. Sort by the difference variable and print out the ten cities.

Methodology: Use proc mean to calculate the average rent price for 2015 
and for 2016 separate. Then take the difference from 2016 and 2015. Use
proc sort to list the cities by the largest difference in rent prices
between the average of 2015 and 2016.

Limitations: This only looks at increase of price. Looking at highest decrease
can also reveal interesting insights.

Followup Steps: I also print out the highest negative difference among those
ten cities.
;

proc print
        data=rentprice_incr_2015_2016_sort(obs=10)
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
'Top 10 cities with largest decrease in average rent from 2015 to 2016'
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
