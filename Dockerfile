FROM nvidia/cuda:12.3.1-base-ubuntu22.04

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    /bin/bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh
    
COPY environment.yml /opt/conda/environment.yml
RUN /opt/conda/bin/conda env create --name CenterNet --file /opt/conda/environment.yml
#RUN conda activate CenterNet
ENV PATH /opt/conda/envs/CenterNet/bin:$PATH

RUN apt update && apt install -y build-essential


# Example
# RUN pip install <additional_dependency>
#WORKDIR /app
#COPY . /app
COPY . .


# Run the installation 
RUN cd src/lib/models/networks/DCNv2/
RUN python src/lib/models/networks/DCNv2/setup.py build develop
#RUN ./make.sh

#solve : ImportError: libGL.so.1: cannot open shared object file: No such file or directory
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

CMD ["python", "src/demo.py", "ctdet", "--demo", "images", "--load_model", "models/ctdet_coco_dla_2x.pth"]

