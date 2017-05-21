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

*
Question: What are the top 5 most expensive US cities in terms of average rent 
price in 2016? Are the 5 least expensive US cities in terms of average rent 
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

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

*
Question: Which month has the lowest average rent price across all the cities 
and which month has the lowest average rent price across all the cities in 2016? 

Rationale: Rent prices fluctuates. This will help us identify when during the 
year can be expect lowest average rent prices and highest rent prices. This will 
also indicate when rental units are most in demand and low supply vs. when demand 
is lower. 

Rationale: 
This will help identify cities where renting may be an issue due to high demand 
and low supply or the opposite. It will also show if there is any interesting 
geographic insights about cities with highest rent - such as 
coastal cities vs. inland cities.)

Methodology: Using PROC Means to caculated the average price across all cities 
and then use print to see what the average rent is for each month.

Limitations: The problem that may occur is if some cities have a different low
season than other cities.

Followup Steps: A possible follow-up is to find the lowest month for each city.
;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

*
Question: Which 3 cities have had the largest increase in rent prices from 
2015 to 2016? 

Rational: This will help indicate which cities are up-and-coming - 
possibly because more people are moving in for job opportunities 
so demand is increasing as well.

Methodology: Use PROC Means to caculate an average for 2015 and for 2016
individually. Then created a new variables that takes the different from
the two averages. Sort by the difference variable and print the top 3 cities.

Limitations: This only looks at increase of price. Looking at highest decrease
can also reveal interesting insights.

Followup Steps: Print the highest negative difference, not only the highest 
positive difference.
;
