
library(mixtools)

# Run this code to estimate categories
# for(i in 2:6){
#   mixMod <- normalmixEM(na.omit(flowData$flow), k=i)
#   plot(mixMod,which=2, breaks=300)
#   #  lines(density(na.omit(flowData$flow)), lty=2, lwd=2)
# }
# based on visual assessment, 5 boundaires looks best with flow boundaries c(10,33,75,166)
# 4 boundaries boundaries = c(0,11,45,120,9999)
# 3 boundaries boundaries = c(0,40,110,9999)

getFlowCategories <- function(flowData, boundaries = c(0,10,31,79,166,9999)){
  
  flowData$flowCatNum <- as.numeric( cut( flowData$flow, breaks = boundaries ) ) - 1
  
  ggplot( flowData, aes(flow, fill = factor(flowCatNum)) ) + geom_histogram( binwidth = 2 )  
  # adjusted boundaries to c(0,10,31,79,166,9999) based on this histo
  table(flowData$flowCatNum)

  return(flowData)
}

