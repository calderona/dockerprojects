FROM rootproject/root-ubuntu16

LABEL author="calderon@cern.ch" \ 
    version="2.0" \ 
    description="Docker image for ROOT-ubuntu16"

USER root 

RUN apt-get update

RUN apt-get install -y \
    apt-utils \
    emacs \ 
    git \
    nano \
    vim \
    wget \
    tar \
    gzip \
    firefox

ENV MG_VERSION="MG5_aMC_v2_6_7"

RUN mkdir /madgraph \
    && wget https://launchpad.net/mg5amcnlo/2.0/2.6.x/+download/MG5_aMC_v2.6.7.tar.gz -O /madgraph/MG5_aMC_v2.6.7.tar.gz \
    && tar -xf /madgraph/MG5_aMC_v2.6.7.tar.gz -C /madgraph \
    && rm -rf /madgraph/MG5_aMC_v2.6.7.tar.gz 

RUN cd /madgraph/MG5_aMC_v2_6_7 \ 
    && wget http://madgraph.physics.illinois.edu/Downloads/MadAnalysis_V1.1.8.tar.gz \
    && tar -xf MadAnalysis_V1.1.8.tar.gz   \			     
    && rm -rf MadAnalysis_V1.1.8.tar.gz

RUN cd /madgraph/MG5_aMC_v2_6_7/MadAnalysis \
    && gfortran -O -w -ffixed-line-length-132 -c plot_events.f \
    && gfortran -O -w -ffixed-line-length-132 -c dbook.f \
    && gfortran -O -w -ffixed-line-length-132 -c rw_events.f \
    && gfortran -O -w -ffixed-line-length-132 -c kin_func.f \
    && gfortran -O -w -ffixed-line-length-132 -c set_cuts.f \
    && gfortran -O -w -ffixed-line-length-132 -o plot_events plot_events.o dbook.o rw_events.o kin_func.o set_cuts.o

RUN cd /madgraph/MG5_aMC_v2_6_7 \
    && wget http://madgraph.phys.ucl.ac.be/Downloads/td64/td

