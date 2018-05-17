# To build it
# docker build -t containerspatterns/rust-launcher -f Dockerfile.launcher .
#
# To run it
# docker run -v /var/run/docker.sock:/var/run/docker.sock --rm containerspatterns/rust-launcher start
FROM alpine

ADD /launcher.sh /app/launcher.sh
ADD /launcher_funcs.sh /app/launcher_funcs.sh

RUN apk add --no-cache \
    ca-certificates \
    curl \
    openssl

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.03.1-ce

RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
      tar --extract \
          --file docker.tgz \
          --strip-components 1 \
          --directory /usr/local/bin/

ENTRYPOINT ["/app/launcher.sh"]
CMD ["start"]