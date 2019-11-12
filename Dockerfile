FROM rootproject/root-ubuntu16

LABEL author="calderon@cern.ch" \ 
    version="1.0" \ 
    description="Docker image for ROOT-ubuntu16"

USER root

RUN apt-get update

RUN apt-get install -y \
    emacs \ 
    git \
    nano \
    vim 
