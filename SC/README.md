# Start tomcat from a sidecar container

```bash
# Run apache httpd in the background
cid=$(docker run -dit -p 8080:80 \
      -v /usr/local/apache2/htdocs/ httpd:2.4)

# Run a sidecar container that updates index.html
docker run --volumes-from ${cid} -ti --rm ubuntu \
sh -c "echo I am the sidecar >> /usr/local/apache2/htdocs/index.html"

# Run a sidecar container that shares the same PID namespace and kill httpd
docker run --pid=container:${cid} -ti --rm ubuntu \
    bash -c "echo -n pid 1 is \$(ps -p 1 -o comm=), killing it...;
            kill 1;
            echo done."
```