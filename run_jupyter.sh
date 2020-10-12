docker run -p 8888:8888 \
	-it \
	--name jupyter_notebook \
	--mount type=bind,source="$(pwd)",target=/home/jovyan/work \
	jupyter/pyspark-notebook:latest

docker rm jupyter_notebook