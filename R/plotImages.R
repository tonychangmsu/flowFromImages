
plotImageGrids <- function(plotWPred = FALSE,imagesPerRow = 12){
  
  flowCatCounts <- as.data.frame(table(imagesDataSorted$flowCatNum))
  
  ii <- 0 # counter for imageNum
  for (i in 1:numFlowCategories) {
    print(paste0("flow category ",i,' out of ',numFlowCategories))
    
    nRows <- flowCatCounts$Freq[i] %/% imagesPerRow + 1
    
    png(paste0("./img/imagePNGs/images_",i,"_wPred_",plotWPred,".png"),
        width = imageWidth * imagesPerRow,
        height = imageHeight * nRows)
    op <- par(mfrow = c(nRows, imagesPerRow), mai = rep_len(0.02, 4))
    
    iii <- 0 # counter for images within flowCat
    for (col in 0:(nRows-1)) {
      for (row in 0:(imagesPerRow-1)) {
        
        iii <- iii + 1
        if(iii <= flowCatCounts$Freq[i]) {
          ii <- ii +1
          plot( (as.raster(deprocess_image(images, imageNum = ii)) ) )
          
          
          if( !plotWPred ){
            if( imagesDataSorted$testImageTF[ii] ){ textLabel <- paste0("Validation_",imagesDataSorted$flowCatNum[ii]); textColor ='orange'} else  {
                                                    textLabel <- paste0("Test_",imagesDataSorted$flowCatNum[ii]); textColor ='White' 
            }
          } else
          {
            if( imagesDataSorted$testImageTF[ii] ){ textLabel <- paste0("Validation_",imagesDataSorted$flowCatNum[ii],"_",imagesDataSorted$p[ii]); textColor ='orange'} else  {
                                                    textLabel <- paste0("Test_",imagesDataSorted$flowCatNum[ii]); textColor ='White' 
            }
          }
          
          text( x = imageWidth/2, y = 20, labels = textLabel, cex = 4, col = textColor )
                       
          #print(c(i,ii,iii))
        }
        
      }
    }
    
    par(op)
    dev.off()
  }
  
}  


# First attempt all on one graph. 
# plotGridOfImages <- function(){
#   
#   flowCatCounts <- as.data.frame(table(imagesDataSorted$flowCatNum))
#   
#   maxNumRowsPerCat <- 2
#   xAxisExtent <- max(flowCatCounts$Freq) * imageWidth / maxNumRowsPerCat
#   
#   yCatOffset <- 6
#   yAxisExtent <- imageHeight * numFlowCategories / maxNumRowsPerCat + yCatOffset * (numFlowCategories - 1)
#   scaleImageHeight <- yAxisExtent/xAxisExtent * maxNumRowsPerCat #* numFlowCategories
#   
#   plot(c(0, xAxisExtent), c(0, yAxisExtent), type = "n", xlab = "", ylab = "")
#   iii <- 0
#   for(z in 0:(numFlowCategories-1)){
#     
#     flowCounts <- flowCatCounts %>% filter(Var1 == z) %>% select(Freq) %>% as.numeric()
#     yCatOffsetInLoop <- z * yCatOffset * maxNumRowsPerCat
#     
#     for(i in 1:(flowCounts)) { 
#       iii <- iii + 1
#       
#       rowNum <- floor(((i-1) * imageWidth) / xAxisExtent)
#       yModOffset <- rowNum * imageHeight * scaleImageHeight
#       
#       xy <- list( ((i-1)*imageWidth) %% xAxisExtent, 
#                   (z)*imageHeight*scaleImageHeight + yCatOffsetInLoop + yModOffset, 
#                   ((i-1)*imageWidth) %% (xAxisExtent) + imageWidth, 
#                   (z)*imageHeight*scaleImageHeight + imageHeight*scaleImageHeight + yCatOffsetInLoop + yModOffset
#       )
#       rasterImage( as.raster(deprocess_image(images, imageNum = iii)), xy[[1]], xy[[2]], xy[[3]], xy[[4]] )
#       #print(c(z,i,iii,unlist(xy),rowNum,yModOffset,yCatOffsetInLoop))
#     }
#     
#   }
# }
