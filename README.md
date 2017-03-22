# README
## Description of Project
The objective of this project is an optimization program designed to arrange
eleven players from pool of thousands of players into a 4-3-3 soccer formation.
Users have the option to select preferences for their team such as:
* "offensiveness" (focus on offense vs. focus on defense)
* "width" (stronger players at the center of the field vs. stronger players at
the edge)
* team budget
The program then returns recommended statistics for the ideal players in each
position on the field. The resulting team fits the style of play and team
budget selected by the user. There is an additional option to have the program
select a set of players that best fit the recommended statistics.

![](/Images/flow_chart.png)

Data on players and their market value are scraped from several websites that
maintain statistics on active soccer players. The main statistics we used
include numbers from the FIFA video game, which keeps a very uniform and
extensive set of statistics based on the performance of real players and teams.

![](/Images/player_stats.png)

We used metamodeling methods to fit curves to the relationship between the
player statistics and their market values. This model is used to select a set
of desired player statistics that result in an optimal team according to our
selected objective function and that fit the contraints of our problem.

![](/Images/data_curve_fit.png)  
A piecewise model was created with a unique curve for each player position

The optimization method was performed in MATLAB with an interior point 
algorithm that uses KKT conditions to arrive at a solution. The GUI was created
in MATLAB's GUI Development Environment (GUIDE).

![](/Images/GUI.png)

## Contents
* **`Images`**- contains images of the GUI, diagrams of of the optimization
problem, and graphs generated in the metamodeling and optimization processes
* **`MATLAB`**- MATLAB files that run the optimization and GUI for the program;
to run, follow the instructions in `README.txt`
* **`presentation`**- a PowerPoint slide deck describing the project
* **`Python_web_scraper`**- contains the Python scripts used to gather player
statistics
* **`Reports`**- contains the proposal for the project and a final report
detailing the final result and an analysis of the optimization used
---
**Technologies used:** Python, MATLAB, Web scraping, MATLAB GUI, Linear and 
Non-linear Mixed Integer Optimization, Linear and Non-linear Regression, 
Metamodeling, Monotonicity Analysis, Sensitivity Analysis  
**Estimated Lines of Code:** 750