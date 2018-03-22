# trying to follow: https://www.data-imaginist.com/2018/lime-v0-4-the-kitten-picture-edition/

library(lime)
#img <- image_read('https://www.data-imaginist.com/assets/images/kitten.jpg')
#img_path <- file.path(tempdir(), 'kitten.jpg')

image_prep_original <- function(x) {
  arrays <- lapply(x, function(path) {
    img <- image_load(path, target_size = c(224,224))
    x <- image_to_array(img)
    x <- array_reshape(x, c(1, dim(x)))
    x <- imagenet_preprocess_input(x)
  })
  do.call(abind::abind, c(arrays, list(along = 1)))
}

image_prep <- function(x) {
  arrays <- lapply(x, function(path) {
    img <- image_load(path, target_size = c(200,375))
    x <- image_to_array(img)
    x <- grayscale(as.cimg(x))
    x <- array_reshape(x,c(1,200,375,1))
  #  x <- imagenet_preprocess_input(x)
  })
  do.call(abind::abind, c(arrays, list(along = 1)))
}

#save an image so it can be read by image_prep
png(paste0("./img/imagePNGs/x_test21.png")); plot( (as.raster(x_test2[1,,,])) ); dev.off() 

img_path <- "./img/imagePNGs/x_test21.png"
img <- image_read(img_path)



explainer <- lime(img_path, model, image_prep)
res <- predict(model, image_prep(img_path))

plot_superpixels(img_path)
plot_superpixels(img_path, n_superpixels = 100, weight = 10)

explanation <- lime:::explain(img_path, explainer, n_labels = 4, n_features = 20)

plot_image_explanation(explanation)
