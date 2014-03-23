
write_irr <- function(fileName,DAP,random) {

  fileName1 <- paste(fileName,"irr",sep=".")
  
cat("\n", file = fileName1 )
cat("   3.1   : AquaCrop Version 3.1plus (January 2011)", file=fileName1, append=TRUE, sep="\n")
cat("   1     : Sprinkler irrigation", file=fileName1, append=TRUE, sep="\n")
cat(" 100     : Percentage of soil surface wetted by irrigation", file=fileName1, append=TRUE, sep="\n")
cat("   1     : Irrigation schedule", file=fileName1, append=TRUE, sep="\n")
cat("\n", file=fileName1, append=TRUE)
cat("   Day    Depth (mm)", file=fileName1, append=TRUE, sep="\n")
cat("====================", file=fileName1, append=TRUE, sep="\n")

cat(paste("   ",DAP,"        ",random, sep=""), file=fileName1, append=TRUE, sep="\n")

}