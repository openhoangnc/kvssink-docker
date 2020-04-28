# kvssink docker
Amazon Kinesis Video Streams Producer - GStreamer kvssink plugin in docker

[![Build Status](https://travis-ci.org/openhoangnc/kvssink-docker.svg?branch=master)](https://travis-ci.org/openhoangnc/kvssink-docker)

```shell
    docker build --tag kvs .
    docker run kvs gst-inspect-1.0 kvssink
```