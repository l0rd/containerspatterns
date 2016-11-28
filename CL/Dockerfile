# To build it
# docker build -t containerslanguages/rust .
#
# To run it
# docker run --rm -t --link mongodb containerslanguages/rust

FROM scorpil/rust:1.11

RUN apt-get update && \
    apt-get install -y g++ make cmake libuv-dev libssl-dev git

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