FROM debian:jessie

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libpython2.7 \
        net-tools \
        python-apsw \
        python-m2crypto \
        python-pkg-resources \
        python-setuptools \
        python2.7 \
        wget && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists

RUN wget "http://dl.acestream.org/linux/acestream_3.1.16_debian_8.7_x86_64.tar.gz" && \
    tar xf acestream_3.1.16_debian_8.7_x86_64.tar.gz && \
    mv acestream_3.1.16_debian_8.7_x86_64 /opt/acestream && \
    rm acestream_3.1.16_debian_8.7_x86_64.tar.gz

ENTRYPOINT ["/opt/acestream/start-engine", "--client-console"]

# http://127.0.0.1:6878/ace/getstream?id=fa59c7d264157f3075941d3dfedb532cabffa009
