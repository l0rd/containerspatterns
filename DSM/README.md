# Go and Mount the Docker Socket container pattern

In this repository we share an example of "Go and Mount the Docker Socket container pattern" for the workshop [5 containers patterns for 5 languages](https://l0rd.github.io/talks/containers-and-languages/index_en.html).

```bash
# The following steps are commented out because 
# not necessary to run the example
# git clone https://github.com/containerslanguages/go

# Build the main.go
# docker build -t containerslanguages/golang-build -f Dockerfile.build .
# docker run -v $(pwd):/code/ -w /code/ containerslanguages/golang-build -o /code/main main.go

# Build the image from scratch
# docker build -t containerslanguages/golang .

docker run -t -v /var/run/docker.sock:/var/run/docker.sock \
               containerslanguages/golang
```
