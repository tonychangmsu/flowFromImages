# flowFromImages

There are very few USGS gages in smaller streams. Most of the work of the Ecology Section at the USGS Conte Lab involves estimating population dynamics of streams fishes. One of the key population drivers is stream flow. Here, we evaluate whether we can us deep learning alogithms to estimate stream flow from cell phone images. The raw images are at fpe.ecosheds.org and were taken during daily dog walks on the Sawmill River in Montague, MA.

We use the keras package in R to estimate flow from images using a 2d convolution network.

To estimate flow using flow categories use 'mainAnalysis_categorical.R'.
To estimate flow using regression use 'mainAnalysis_regression.R'

Original images are accessed from flickr and stored in the /img directory
Subsetted and processed images can be viewed as png files in the /img/imagePNGs directory (see below for examples)

## Low flow images
![Screenshot](images_2_wPred_RegressionFALSE.png)

## High flow images
![Screenshot](images_6_wPred_RegressionFALSE.png)

As of 3/19/18, the model are overfit. Need to develop better models.
