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

Dataset Name: rentprice_analytic_file created in external file
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
        data=rentprice_analytic_file
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
"As can be seen, there are the cost of living in Beijing and San Francisco."
;

footnote2
"the cost of living in San Francisco is higher than Beijing."
;

*
Note: This would involve making either a frequency chart to show 
the living cost in San Francisco.

Methodology:Compute five-number summaries by Cappuccino, Cinema, Wine, 
Gasoline, Avg Rent and Avg Disposable Income from the dataset, 
and output the results to a temporary dataset. Use PROC PRINT to print
the Beijing and San Francesco observations from the temporary dataset.

Limitations: This methodology does not account for schools with missing data,
nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean the values of the variable.
;

proc means
        min q1 median q3 max
        data=rentprice_analytic_file
    ;
    class
        City
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
;

*
Note: This would involve the crime rate, and then we can make a table 
to see the relationship.

Methodology: Use PROC PRINT to print the first ten observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: This methodology does not account for districts with missing data,
nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean the values of the variable.
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
