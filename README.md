# Overview

I decided that I wanted to learn the R language, and so what better way to learn R than to try to figure out how to program and graph a simulation. I am generally interested in simulations, and the more I learned about R, I found out that it was perfect for this type of project. I looked around and found that the SIR model was a simulation of a disease and how it spreads, and how many people are going to get infected, and how many are going to recover from the infection. What I wanted to learn in R would be learning how to write several functions and variables, and also how to graph something. The SIR model would fit all of those criteria. 

So the software I wrote is an SIR model of the population of Hong Kong during 2020 and COVID. So I would be simulating the number of people that would be getting infected and recovering from COVID to help get a basic idea of how diseases spread, and even compare it to the actual COVID numbers. I wrote additional programs past the initial SIR model just to test things out and experiment. The first experiment would be one where I used a for loop to test out how the different inputs for susceptible, infected, and recovered, and see how that affects the SIR model. After that, I wanted to use complex numbers in some sort of way, and also randomly generate the recovery and infection rate to see how that affected the model and the relationship between the infected and recovery rate. Lastly, I also wrote a more fun random complex number function, as I wanted to do an oscillating SIR model with complex numbers, but I had run out of time to implement and figure out how to change my current code to match that.

My purpose for doing this project was because I wanted to see how useful R could be in modeling and graphing infection rates. I think this would be useful to have if we had another epidemic, so I could figure out how deadly or how contagious it would be. It would also be helpful to see how long it would take for the general population to recover.  

{Provide a link to your YouTube demonstration. It should be a 4-5 minute demo of the software running and a walkthrough of the code. Focus should be on sharing what you learned about the language syntax.}

[Quick view and explanation of my SIR model R code](https://youtu.be/rXy3Tj8AtMU)
[In-depth view of my SIR model R code](https://youtu.be/o8ltDBjpiq0)
# Development Environment

R Studio
    Packages within R used:
    - DeSolve
    - Reshape2
    - ggplot2

R version 4.5.1

Github
# Useful Websites

- [Data set for SIR Model](https://www.kaggle.com/datasets/sudalairajkumar/novel-corona-virus-2019-dataset)
- [Library for ggplot2 commands for R](https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf)
- [For Loops In R](https://www.w3schools.com/r/r_for_loop.asp)
- [Help for SIR model within R](https://rpubs.com/choisy/sir)
- [Helped me with for loops and increments](https://stackoverflow.com/questions/46546675/r-for-loop-increment-by-5s-but-start-at-1)
- [Functions in R](https://www.w3schools.com/r/r_functions.asp)
- [Writing SIR model in R article](https://rpubs.com/choisy/sir)
- [Writing SIR model in R youtube](https://youtu.be/NHtHQACcO9Q?si=l35e1TcVzNFVwxky)

# Future Work

- Implement oscillating complex numbers to see how that affects the SIR model (mimic higher infection rates in winter) 
- Work on the random infection rate and Recovery to be more visible for the user
- Work on making the graph show where the peak infection is, and make the graph mimic that for easier viewing


