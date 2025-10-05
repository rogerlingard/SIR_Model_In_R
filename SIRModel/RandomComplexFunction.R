random_complex <- function(){
  x_complex <- runif(1, min=0.001, max=0.005)
  y_complex <- runif(1, min=0.0005, max=0.005)
  complex_number <- complex(real = x_complex, imaginary =  y_complex)
  cat(typeof(complex_number))
  return(complex_number)
  
}
beta <- random_complex()
print(beta)
