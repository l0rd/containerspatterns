# To build it
# docker build -t containerspatterns/rust .
#
# To run it
# docker run --rm -t --link mongodb containerspatterns/rust

FROM rust:1.26

RUN apt-get update && \
    apt-get install -y build-essential cmake git libssl-dev git

RUN wget http://dist.libuv.org/dist/v1.14.0/libuv-v1.14.0.tar.gz && \
    tar xzf libuv-v1.14.0.tar.gz && \
    cd libuv-v1.14.0 && \
    sh autogen.sh && \
    ./configure && \
    make install

RUN git clone https://github.com/datastax/cpp-driver.git && \
    mkdir cpp-driver/build && \
    cd cpp-driver/build && \
    cmake .. && \
    make && \
    make install

ADD / /code/

WORKDIR /code/

RUN cargo build

CMD /code/target/debug/sample