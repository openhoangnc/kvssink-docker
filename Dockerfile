FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV CC clang
ENV CC_FOR_BUILD clang
ENV CXX clang++
ENV CXX_FOR_BUILD clang++
ENV GST_PLUGIN_PATH /kvs-producer

RUN apt update
RUN apt install -y \
        autoconf \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        build-essential \
        gstreamer1.0-tools \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-plugins-good \
        wget \
        clang \
        git \
        cmake

RUN clang --version

RUN wget http://ftp.gnu.org/gnu/automake/automake-1.16.1.tar.gz && tar xzvf automake-1.16.1.tar.gz && cd automake-1.16.1 && ./configure && make && make install && cd ..

RUN git clone --depth=1 --recursive https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp.git kvs-producer-sdk

RUN mkdir -p ${GST_PLUGIN_PATH} && cd ${GST_PLUGIN_PATH} \
    && cmake /kvs-producer-sdk -DBUILD_GSTREAMER_PLUGIN=TRUE \
    && make \
    && cd /

# cleanup
# RUN rm -rf kvs-producer-sdk
RUN apt remove -y \
    wget \
    clang \
    git \
    cmake \
    build-essential \
    autoconf \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    && apt autoremove -y

RUN gst-launch-1.0 --version
RUN gst-inspect-1.0 kvssink

SHELL ["/bin/bash", "-c"]