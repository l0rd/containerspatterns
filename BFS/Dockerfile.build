## docker build -t tictac-build -f Dockerfile.build .
## docker run -v $(pwd):/code/ -w /code/ tictac-build

FROM golang:1.6.3

RUN go get github.com/parnurzeal/gorequest

ENV CGO_ENABLED "0"
ENV GOOS "linux"
ENV GOARCH "amd64"

ENTRYPOINT ["go"]
CMD ["build","-a","--installsuffix","cgo","--ldflags=\"-s\"","-o","tictac"]
