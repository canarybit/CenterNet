FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

# Install Conda
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    /bin/bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh
    

# Init Conda 
COPY environment.yml .
RUN /opt/conda/bin/conda env create -f environment.yml
SHELL ["/opt/conda/bin/conda", "run", "-n", "CenterNet", "/bin/bash", "-c"]
ENV PATH /opt/conda/envs/CenterNet/bin:$PATH

# Copy the working directory
COPY . .

#Install Cuda Drivers
RUN apt install -y gcc
RUN apt install -y ubuntu-drivers-common                                 

# Run the installation 

RUN apt update && apt install -y build-essential
RUN /opt/conda/bin/conda install pytorch==1.1.0 torchvision==0.3.0 -c pytorch
#RUN pip install opencv-python==4.5.4.60
RUN pip install -r requirements.txt


#Solve : ImportError: libGL.so.1: cannot open shared object file: No such file or directory
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y


RUN chmod +x /start.sh
CMD ["/start.sh"]

