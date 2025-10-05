#A function trying to figure out how to generate a random complex number
random_complex <- function(){
  x_complex <- runif(1, min=0.001, max=0.005)
  y_complex <- runif(1, min=0.0005, max=0.005)
  complex_number <- complex(real = x_complex, imaginary =  y_complex)
  return(complex_number)
  
}
beta <- random_complex()
print(beta)
