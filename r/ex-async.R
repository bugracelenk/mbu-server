needs(dplyr)
attach(input[[1]])

Rho <- Lambda/Mue
matrix <- matrix(0, maxMachineCount, 2)
matrix[,1] <- 1:maxMachineCount

calculatewq <- function(c) {
  P0inv <- Rho^c/(factorial(c)*(1-(Rho/c)))
  for(i in 1:c-1) {
    P0inv = P0inv + (Rho^i)/factorial(i)
  }

  P0 = 1/P0inv
  Lq = (Rho^(c+1))*P0/(factorial(c-1)*(c-Rho)^2)
  Wq = 60*Lq/Lambda
  Ls <- Lq + Rho
  Ws <- 60*Ls/Lambda
  a <- cbind(Lq,Wq,Ls,Ws)
  return(a)
}

for (i in 1:maxMachineCount){
  matrix[i,2] <- calculatewq(i)[2]
}

return(matrix)