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

Methodology:

Limitations: 

Followup Steps:
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

Methodology:

Limitations: 

Followup Steps:
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

Methodology:

Limitations: 

Followup Steps:
;
