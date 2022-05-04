FROM ubuntu:20.04

ARG rtiversion="22.0.22076.204"

RUN export DEBIAN_FRONTEND=noninteractive && dpkg --add-architecture i386 && \
    apt-get update \
    && apt-get install -y wget unzip libcomerr2:i386 libfontconfig1:i386 libfreetype6:i386 \
    libgl1-mesa-glx:i386 libgssapi-krb5-2:i386 libk5crypto3:i386 libkrb5-3:i386 \
    libreadline5:i386 libsqlite3-0:i386 libstdc++6:i386 libx11-6:i386 \
    libxext6:i386 libxrender1:i386 zlib1g:i386 libxslt1.1:i386 libxml2:i386 libfontconfig libglib2.0-0 \
    libsm-dev libxrender-dev libxext-dev libxt-dev libgstreamer1.0 libgstreamer-plugins-base1.0

RUN export uid=1000 gid=1000 && \
    apt-get install -y sudo && \
    mkdir -p /home/rtiuser && \
    echo "rtiuser:x:${uid}:${gid}:RTIUser,,,:/home/rtiuser:/bin/bash" >> /etc/passwd && \
    echo "rtiuser:x:${uid}:" >> /etc/group && \
    echo "rtiuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/rtiuser && \
    chmod 0440 /etc/sudoers.d/rtiuser && \
    chown ${uid}:${gid} -R /home/rtiuser

RUN cd /root && wget "https://www.gov.uk/government/uploads/uploaded/hmrc/payetools-rti-$rtiversion-linux.zip" && \
    unzip "payetools-rti-$rtiversion-linux.zip" && \
    ./payetools-rti-$rtiversion-linux --userdatamode 1 --createshortcut 0 --installtype typical --mode unattended

USER rtiuser

ENV HOME /home/rtiuser
CMD ["/opt/HMRC/payetools-rti/rti.linux","-a"]