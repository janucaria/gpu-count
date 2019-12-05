FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib:/usr/local/cuda/lib64:/usr/local/cuda/compat

WORKDIR /tmp

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y software-properties-common \
  && apt-get install -y cmake \
  && apt-get install -y pkg-config \
  #
  && add-apt-repository ppa:ubuntu-toolchain-r/test \
  && apt-get update \
  && apt-get install -y g++-8 \
  && update-alternatives \
  --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 \
  --slave /usr/bin/g++ g++ /usr/bin/g++-8 \
  && update-alternatives --config gcc \
  && true

ENV DEBIAN_FRONTEND=

WORKDIR /app

COPY ./CMakeLists.txt /app/
COPY ./src /app/src
COPY ./tools /app/tools

RUN ./tools/run-configure-and-build.sh \
  && cp ./build/gpu-count /usr/local/bin
