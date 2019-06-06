FROM rocker/tidyverse:latest

RUN mkdir /home/analysis

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libtiff-dev software-properties-common build-essential libgtk2.0-dev libcairo2-dev xvfb xauth xfonts-base libmagick++-dev python-dev python-pip

RUN pip install Pillow numpy scipy pandas

RUN R -e "options(repos = \
  list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2019-01-06/')); \
  install.packages(c('keras', 'arrayhelpers', 'magick', 'mixtools', 'imager', 'waterData'),\
  dependencies=TRUE)"
