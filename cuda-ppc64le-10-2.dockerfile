FROM nvidia/cuda-ppc64le:10.2-cudnn7-devel-ubuntu18.04

RUN apt-get update \
  && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates \
  && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/ppc64el/7fa2af80.pub | apt-key add - \
  && echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/ppc64el /" > /etc/apt/sources.list.d/cuda.list \
  && echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/ppc64el /" > /etc/apt/sources.list.d/nvidia-ml.list \
  && apt-get update \
  && apt-get install cuda-compat-10-2 \
  && apt-get purge --autoremove -y curl \
  && rm -rf /var/lib/apt/lists/* \
  && true

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
