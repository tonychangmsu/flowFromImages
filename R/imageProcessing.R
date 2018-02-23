
#https://github.com/rstudio/keras/blob/master/vignettes/examples/deep_dream.R 
preprocess_image <- function(image_path, height, width){
  tmp <- image_load(image_path, target_size = c(height, width)) %>%
    image_to_array() %>%
    array_reshape(dim = c(1, dim(.)))   #%>%
  # imagenet_preprocess_input() #seems to center data
  
  i <- tmp/255
  return(i)

}

deprocess_image <- function(x,imageNum){
  x <- x[imageNum,,,] * 255
  
  # Remove zero-center by mean pixel
  # Needed if use imagenet_preprocess_input() in preprocess_image(). Not using because not using imagenet images
  x[,,1] <- x[,,1] #+ 103.939
  x[,,2] <- x[,,2] #+ 116.779
  x[,,3] <- x[,,3] #+ 123.68
  
  # 'BGR'->'RGB'
  x <- x[,,c(3,2,1)]
  
  # Clip to interval 0, 255
  x[x > 255] <- 255
  x[x < 0] <- 0
  x[] <- as.integer(x)/255
  x
}

deprocess_images <- function(x){
  x <- x[,,,] * 255
  
  # Remove zero-center by mean pixel
  x[,,,1] <- x[,,,1] #+ 103.939
  x[,,,2] <- x[,,,2] #+ 116.779
  x[,,,3] <- x[,,,3] #+ 123.68
  
  # 'BGR'->'RGB'
  x <- x[,,,c(3,2,1)]
  
  # Clip to interval 0, 255
  x[x > 255] <- 255
  x[x < 0] <- 0
  x[] <- as.integer(x)/255
  x
}


processImages <- function( imagesData = imagesData, imageSize = "s", height, width){
  
  #image <- array(NA,c(nrow(imagesData),imagesData$height_s[1],imagesData$width_s[1],3))
  image <- array(NA,c(nrow(imagesData),height,width,3))
    
  for (i in 1:nrow(imagesData)){
    
    imgName <- paste0("./img/sawmill_",substr(imagesData$datetaken[i], 1, 10),'_',imageSize,'.jpg')
    img_height <- height #imagesData$height_s[i] #just hardcode '_s' for now
    img_width <- width #imagesData$width_s[i]
    img_size <- c(img_height, img_width, 3)
    image[i,,,] <- preprocess_image(imgName, img_height, img_width)
  
  }
  return (image)
}

removeImagesWithIce <- function(d){
  
  iceDays <- c('2017-01-11','2017-01-12',
               '2017-03-15','2017-03-16',
               '2017-12-16','2017-12-17',
               '2018-01-02','2018-01-03','2018-01-04','2018-01-05','2018-01-06','2018-01-08','2018-01-09','2018-01-11','2018-01-12',
               '2018-02-08','2018-02-09','2018-02-10')
  
  d <- d %>% filter(!(date %in% iceDays))
  return(d)
}