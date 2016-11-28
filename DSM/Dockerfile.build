# docker build -t containerslanguages/golang-build -f Dockerfile.build .
# docker run -v $(pwd):/code/ -w /code/ containerslanguages/golang-build -o /code/main main.go
FROM golang:1.6.3

RUN go get github.com/fsouza/go-dockerclient \
        github.com/docker/go-units

ENV CGO_ENABLED "0"
ENV GOOS "linux"
ENV GOARCH "amd64"
ENTRYPOINT ["go","build","-a","-installsuffix", "cgo"] 