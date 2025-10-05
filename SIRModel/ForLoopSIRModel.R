#References and links that heavily helped me in writing my code below
#https://rpubs.com/choisy/sir
#https://youtu.be/NHtHQACcO9Q?si=l35e1TcVzNFVwxky

library("deSolve")
#this is a package that is used to help solve differential equations, making it easier to solve them
library(ggplot2)
#this is a package that is going to help with graphing our SIR model.
library(reshape2)


getwd()
#Double checking where we are and making sure that access the right file.

covid_numbers <- read.csv("covid_19_data.csv", header = TRUE, sep = ",")
#Creates a list using a CSV file for that Dataframe. Which we are going to use for our Covid Numbers

data.frame(covid_numbers)
#makes it into a data frame for us to use.

instances <- covid_numbers[covid_numbers$Province.State == "Hong Kong", ]
#We are now targeting the specific province of Hong Kong so we can find out it's Susceptible, infected, and recovered


province <- "Hong Kong"


x_axis <- "Time in Days"
y_axis <- "Number of People"
#Setting x and y variable names for our graph

data.frame(instances)

N <- 7509200
#Hong Kong Population around mid 2020 according to https://www.censtatd.gov.hk/en/press_release_detail.html?id=4669#:~:text=For%20those%20Hong%20Kong%20Permanent,be%20released%20in%20February%202021.&text=Upcoming%20release%20date:
beta <- 0.5
#Found this information according to this site https://link.springer.com/article/10.1186/s40249-020-00640-3 and https://pmc.ncbi.nlm.nih.gov/articles/PMC8993010/#sec002  
#this is the transmission rate

gamma <- 0.13
#Like above found on the same websites, This is the recovery rate


parameters_values <- c(
  beta, #Our Infection Rate
  gamma #Our Recovery Rate
)
#we are making a vector here for our parameter values that we are going to use. Outside our loop because they will be kept constant

sir_model <- function(time, province, parameters) {
  with(as.list(c(province,parameters)), {
    dS <- -beta * S * I / N #getting dS/dt
    dI <- beta * S * I / N - gamma * I #getting dI/dt
    dR <- gamma * I #getting dR/dt
    return(list(c(dS, dI, dR)))
  })
}
#Our Function to get dS, dI, dR, which will all be lists.

time_values <- seq(0, 70)
#the period in which we can see the infected and susceptible and recovered change in numbers.
days_observed <- length(instances$ObservationDate)

#I was curious to see how changing the SIR numbers affected the SIR graph. So I made a for loop that went through instances to use different values to see if we got different outcomes.
for(i in seq(from = 2, to = days_observed, by = 10)){
  R <- instances[i,"Recovered"]
  
  I <- instances[i, "Confirmed"]
  
  S <- N - I
  
  
  initial_values <- c(
    S = S,
    I = I,
    R = R
  )
  
  #ode is a part of desolve, which allows us to solve the differential equations needed for the SIR model. We can do it within R.
  sir_values <- as.data.frame(ode(
    y = initial_values,
    times = time_values,
    func = sir_model,
    parms = parameters_values
  ))
  
  #We are making it into a data frame so we can use ggplot to plot this on a graph. 
  sir_value_full <- melt(as.data.frame(sir_values), id="time")
  sir_value_full
  
  
  
  #For my own curious brain, and to see if the amount of days change and when. 
  index <- which.max(sir_values$I)
  infected_number <- sir_values$I[index]
  infected_time <- sir_values$time[index]
  greater_than_thirty_days <- infected_time > 30
  
  
  #This is who we graph. Data is what data frame we are using, aes is what we are using to plot our x and y 
  sir_graph <- ggplot(data = sir_value_full, aes(x = time, y = value, color = variable)) + 
    geom_line() +
    labs(title = "SIR Model",
         x = x_axis, y = y_axis, color = "Compartment") +
    theme_classic() +
    geom_line(linewidth = 1) +
    scale_y_continuous(labels = scales::comma, 
                       breaks = seq(0, 7500000, by = 500000)) +
    theme(axis.title.y = element_text(margin = margin(r = 10))) 
  print(sir_graph)
  if (greater_than_thirty_days){
    print("We reached the peak amount of infected people after thirty days")
    print(paste("It took ", infected_time, "days to reach the peak of the amount of infected people."))
    cat("\n")
  } else {
    print("We reached the peak amount of infected people before thirty days")
    print(paste("It took ", infected_time, "days to reach the peak of the amount of infected people."))
    cat("\n")
  }
  Sys.sleep(5)
}

