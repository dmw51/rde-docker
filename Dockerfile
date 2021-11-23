FROM continuumio/miniconda3
RUN apt-get update &&\
apt-get install -y wget build-essential

WORKDIR /opt/conda

COPY . . 
RUN conda install -y python=3.6 conda-build &&\
conda config --add channels conda-forge &&\
conda config --add channels chemdataextractor&&\
conda config --add channels mcs07
RUN cd ./rde-conda/recipes/pyosra3.6 && conda build . &&\
cd ../reactiondataextractor && conda build . &&\
conda config --add channels /opt/conda/conda-bld && conda install reactiondataextractor &&\
cd /opt/conda && rm -r conda-bld/
RUN cde data download
