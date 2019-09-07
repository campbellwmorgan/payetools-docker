#!/bin/bash

set -e

RTI_VERSION=${$RTI_VERSION:-19.1.19116.1393}

mkdir -p $HOME/HMRC || true

docker run -it --rm \
    -e QT_X11_NO_MITSHM=1 \
    -e XDG_RUNTIME_DIR=/tmp \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY  \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/HMRC:/home/rtiuser/HMRC \
    -p 127.0.0.1:46729:46729 \
    --user=$(id -u):$(id -g) \
    --network=host \
    payetoolsrti:$RTI_VERSION /opt/HMRC/payetools-rti/rti.linux