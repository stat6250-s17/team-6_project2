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
Question: What are the top five highest rent price of cities? 

Rationale: This should help identify the highest rent price of cities. 
The rent price is the first thing that anyone who moves here will think about, 
because the rent is the largest proportion of people's cost. 

Note: This would involve average rent of cites, and then we can 
make a table to see the relationship.


Methodology: 

Limitations: 

Followup Steps:
;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Where does San Francisco rank in terms of cost of living? 

Rationale: We came to San Francisco Bay Area for study. We need to realize 
how much of living cost to pay. So, I want to know what level about cost in 
San Francisco to measure I can pay.

Note: This would involve making either a frequency chart to show 
the living cost in San Francisco.

Methodology: 

Limitations: 

Followup Steps:
;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Which three of city have the lower crime rate? 

Rational: Low crime rate is good. The lower the score the safer people feel 
in this city. By the proportion of crime, we know which cities are 
more suitable for human habitation.

Note: This would involve the crime rate, and then we can make a table 
to see the relationship.

Methodology:

Limitations: 

Followup Steps:
;
