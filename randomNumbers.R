
# Load code to write irr files

source("write_irr.R")

# load the random number data

randomNumbers <- read.table("randomNumbers.csv",sep=",",header=T)

# load the 'day after planting' and depth data
# This data is what determines the output that you get

DAPs <- read.table("DAP.csv",sep=",",header=TRUE)

# Name vectors using the levels DRY, VERY DRY...etc etc

irrig <- levels(DAPs$water)
soils <- levels(DAPs$soil)

# Three nested for loops which relate to:
# k = Linear/Boom
# i = average/dry/very_dry/very_wet/wet
# j = sand/sandyloam

for (k in 1:2) {
  
  
# This line reads in from a file of numbers representing the rainfall distribution.
# Ideally this would be calculated in R!
  
  randomNumbers <- na.omit(read.table("randomNumbers.csv",sep=",",header=T,))
  
  for (i in 1:length(irrig)) {
  
  for (j in 1:length(soils)) {
    
    
    # Subset the DAP data into the dryness and soil type
    
    DAPMatrix <- subset(DAPs,water == irrig[i] & soil == soils[j])
    
    # repeat the DAP values ten times
    
    depthMatrix <- rep(subset(DAPs,water == irrig[i] & soil == soils[j], DEPTH)[,1],10)
    
    # For each time there is a DAP value, this line randomly selects (samples) a number from the
    # randomNumbers text file...
    
    randomNumberMatrix<- sapply(depthMatrix, function(x) {
      
      x + ceiling(sample(randomNumbers[,k],1)/100 * x)
      
    }
    ) 
    
    # this line changes the vector back into a matrix of rows and columns
    
    dim(randomNumberMatrix) <- c(nrow(DAPMatrix),10)
    
    # This line just reads it back so you can check it
    # this can always be output to a text file if you want?
    
    randomNumberMatrix
    
    # This next function basically does all the file writing....
    
    write_multiple_irr_files <- function(x) {
      
      for (i in 1:10) {
        
        fileName1 <- paste(
          "irr/",
          unique(DAPMatrix[,"soil_a"]),
          "_",
          substr(names(randomNumbers)[k],1,1),
          "_",
          unique(DAPMatrix[,"water_a"]),
          "_",
          i,
          sep=""
        )
        
        write_irr(fileName1,DAPMatrix$DAP,randomNumberMatrix[,i])
        
      }
      
    }
    
    # Run the function...and that's it!
    
    write_multiple_irr_files()
    
      }
    
    }

}
