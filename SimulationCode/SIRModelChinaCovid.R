#References and links that heavily helped me in writing my code below
#https://rpubs.com/choisy/sir
#https://youtu.be/NHtHQACcO9Q?si=l35e1TcVzNFVwxky

#Uncomment if you need these packages
#install.packages("deSolve")
#install.packages("reshape2")
library("deSolve")
#this is a package that is used to help solve differential equations, making it easier to solve them
library(ggplot2)
#this is a package that is going to help with graphing our SIR model.
library(reshape2)


getwd()
#Double checking where we are and making sure that access the right file.

covid_numbers <- read.csv("covid_19_data.csv", header = TRUE, sep = ",", header = TRUE, sep = ",")
#Creates a list using a CSV file for that Dataframe. Which we are going to use for our Covid Numbers

data.frame(covid_numbers)
#makes it into a data frame for us to use.

instances <- covid_numbers[covid_numbers$Province.State == "Hong Kong", ]
#We are now targeting the specific province of Hong Kong so we can find out it's Susceptible, infected, and recovered


province <- "Hong Kong"

data.frame(instances)

days <- length(instances$ObservationDate)
#Since every entry within the observation date is unique and sequential we can just count the number of items within the column and that will be the amount of total days.

R <- instances[2,"Recovered"]

N <- 7509200
#Hong Kong Population around mid 2020 according to https://www.censtatd.gov.hk/en/press_release_detail.html?id=4669#:~:text=For%20those%20Hong%20Kong%20Permanent,be%20released%20in%20February%202021.&text=Upcoming%20release%20date:

I <- instances[2, "Confirmed"]

S <- N - I

beta <- 0.5
#Found this information according to this site https://link.springer.com/article/10.1186/s40249-020-00640-3 and https://pmc.ncbi.nlm.nih.gov/articles/PMC8993010/#sec002  
#this is the transmission rate

gamma <- 0.13
#Like above found on the same websites, This is the recovery rate


time <- seq(0, 100)

sir_model <- function(time, province, parameters) {
  with(as.list(c(province,parameters)), {
    dS <- -beta * S * I / N #getting dS/dt
    dI <- beta * S * I / N - gamma * I #getting dI/dt
    dR <- gamma * I #getting dR/dt
    return(list(c(dS, dI, dR)))
  })
}
#Our Function to get dS, dI, dR, which will all be lists.
parameters_values <- c(
  beta, #Our Infection Rate
  gamma #Our Recovery Rate
)

initial_values <- c(
  S = S,
  I = I,
  R = R
)

time_values <- seq(0, 70)

sir_values_1 <- as.data.frame(ode(
  y = initial_values,
  times = time_values,
  func = sir_model,
  parms = parameters_values
))

sir_value_1_full <- melt(as.data.frame(sir_values_1), id="time")
sir_value_1_full
# sir_values_1 <- data.frame(sir_values_1) # Removed redundant conversion

x_axis <- "Time in Days"
y_axis <- "Number of People"
typeof(sir_values_1)
ggplot(data = sir_values_1, aes(x = time_values, y = sir_values_1)) + 
  geom_line() +
  labs(title = "SIR Model",
       x = x_axis, y = y_axis, colour = "Compartment") +
  theme_classic()

