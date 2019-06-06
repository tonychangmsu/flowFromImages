nvidia-docker run -it --rm -v $(pwd):/contents -w /contents -p 8888:8888 -e PASSWORD=jupyter tonychangcsp/keras:latest jupyter notebook --port 8888 --ip 0.0.0.0 --no-browser --allow-root 
