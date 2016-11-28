# Javascript and Copy Sources container pattern

In this repository we share an example of "Javascript and Mount the Sources container pattern" for the workshop [5 containers patterns for 5 languages](https://l0rd.github.io/talks/containers-and-languages/index_en.html).

```bash
# The following steps are commented out because
# not necessary to run the example
# git clone --recursive https://github.com/containerslanguages/js

docker build -t 2048 .
docker run -d -p 8080:80 2048
```
