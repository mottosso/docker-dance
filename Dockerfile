# /*********************************************************
# Copyright 2005 by Ari Shapiro and Petros Faloutsos
# DANCE
# Dynamic ANimation and Control Environment
# -----------------------------------------
# AUTHOR:
# Ari Shapiro (ashapiro@cs.ucla.edu)
# ORIGINAL AUTHORS:
# Victor Ng (victorng@dgp.toronto.edu)
# Petros Faloutsos (pfal@cs.ucla.edu)
# CONTRIBUTORS:
# Yong Cao (abingcao@cs.ucla.edu)
# Paco Abad (fjabad@dsic.upv.es)
# **********************************************************/

FROM ubuntu:12.04

RUN mkdir -p /home/docker

WORKDIR /home/docker

ENV HOME /home/docker
ENV DANCE_DIR /home/docker/dance_v4

COPY fltk-2.0.x-alpha-r9296.tar.gz   ${HOME}/
COPY dance_v4_082812.2258.zip        ${HOME}/
COPY ode-0.11.1.zip                  ${HOME}/
COPY ImageMagick-6.4.5-3.tar.gz      ${HOME}/
COPY lib3ds-1.3.0.zip                ${HOME}/
COPY Python-2.5.2.tgz                ${HOME}/
COPY numpy-1.2.1.tar.gz              ${HOME}/

# System
RUN apt-get update && apt-get install -y \
    nano \
    wget \
    unzip \
    libx11-dev \
    xorg-dev \
    autoconf \
    freeglut3-dev \
    libjpeg-dev \
    build-essential \
    mesa-utils

RUN unzip dance_v4_082812.2258.zip -d ${HOME} && \
    mv dance_v4_082812.2258/dance_v4 ${HOME}

# FLTK
RUN tar -xf ${HOME}/fltk-2.0.x-alpha-r9296.tar.gz -C ${DANCE_DIR}/extensions && \
    cd ${DANCE_DIR}/extensions/fltk-2.0.x-alpha-r9296 && \
    ./configure --prefix=${DANCE_DIR} --enable-shared && \
    make && make install

# ODE
RUN unzip -o ${HOME}/ode-0.11.1.zip -d ${DANCE_DIR}/extensions && \
    cd ${DANCE_DIR}/extensions/ode-0.11.1 && \
    autoconf && \
    ./configure -prefix=${DANCE_DIR} \
        --enable-double-precision \
        -enable-shared && \
    make && make install

# ImageMagick
RUN tar -xf ${HOME}/ImageMagick-6.4.5-3.tar.gz -C ${DANCE_DIR}/extensions && \
    cd ${DANCE_DIR}/extensions/ImageMagick-6.4.5 && \
    ./configure \
        --prefix=${DANCE_DIR} \
        --enable-shared \
        --without-perl \
        --with-quantum-depth=8 && \
    make && make install

# lib3ds
RUN unzip -o ${HOME}/lib3ds-1.3.0.zip -d ${DANCE_DIR}/extensions && \
    cd ${DANCE_DIR}/extensions/lib3ds-1.3.0 && \
    ./configure --prefix=${DANCE_DIR} && \
    make && make install

# Python
ENV LD_LIBRARY_PATH ${DANCE_DIR}/extensions/Python-2.5.2
RUN tar -xf ${HOME}/Python-2.5.2.tgz -C ${DANCE_DIR}/extensions && \
    cd ${DANCE_DIR}/extensions/Python-2.5.2 && \
    ./configure \
        -prefix=${DANCE_DIR} \
        -enable-shared && \
    make && make install

RUN cd ${DANCE_DIR} && \
    make

ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${DANCE_DIR}/lib

# Start comamand
CMD ${DANCE_DIR}/bin/dance