# https://livebook.manning.com/#!/book/deep-learning-with-r/chapter-5/295

numLayers <- 12

plot_channel <- function(channel) {
  rotate <- function(x) t(apply(x, 2, rev))
  image(rotate(channel), axes = FALSE, asp = 1,
        col = terrain.colors(12))
}

# get test image
img_tensor <- array_reshape( x_test2[1,,,], c(1,dim(images)[2],dim(images)[3],numColors) )
plot(as.raster(img_tensor[1,,,]))

# define activation model
layer_outputs <- lapply(model$layers[1:numLayers], function(layer) layer$output)      
activation_model <- keras_model(inputs = model$input, outputs = layer_outputs)

# get activations
activations <- activation_model %>% predict(img_tensor)         

# show examples
first_layer_activation <- activations[[1]]
dim(first_layer_activation)

plot_channel(first_layer_activation[1,,,2])
plot_channel(first_layer_activation[1,,,7])

# plot all activations
image_size <- 116
images_per_row <- 16

for (i in 1:numLayers) {
  
  layer_activation <- activations[[i]]
  layer_name <- model$layers[[i]]$name
  
  n_features <- dim(layer_activation)[[4]]
  n_cols <- n_features %/% images_per_row
  
  png(paste0("./img/imgActivations/flow_activations_",convertToGrayscale,"_", i, "_", layer_name, ".png"),
      width = image_size * images_per_row,
      height = image_size * n_cols)
  op <- par(mfrow = c(n_cols, images_per_row), mai = rep_len(0.02, 4))
  
  for (col in 0:(n_cols-1)) {
    for (row in 0:(images_per_row-1)) {
      channel_image <- layer_activation[1,,,(col*images_per_row) + row + 1]
      plot_channel(channel_image)
    }
  }
  
  par(op)
  dev.off()
}



