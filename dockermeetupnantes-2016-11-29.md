name: inverse
layout: true
class: center, middle, inverse
---
layout: false
template: inverse
class: center, middle

<br><br>
# Containers Patterns
<br><br><br>


---
template: inverse

## Hello

---
layout: false

.large[
<br>
.left[Haikel (@hguemar)..............![haikel](images/haikel-round.png) ![redhat](images/redhat.png)]
<br>
.left[Mario (@mariolet)................![mario](images/mario-round.png) ![redhat](images/redhat.png)]
<br>
.left[Mike (@mjbright).................![mike](images/mike-round.png) ![hp](images/hpe.png)]
]

---

template: inverse

## What is this talk about?

---
layout: false

## Patterns?

.center[![gof](images/gof-mod.png)]

---
.tc-left-column[
.footnote[@hguemar, @mariolet, @mjbright ]
  ## Patterns
  #### Development Patterns
  `Copy Sources`
<br><br>
  `Mount Sources`
<br><br>
  `Dockerize Your Tools`
<br><br>
  `ONBUILD Image`
<br><br>
  `Dependencies First Dockerfile`
]
.tc-center-column[
<br>
  #### Distribution Patterns
  `Build From Scratch`
<br><br>
  `Containers Launcher`
]
.tc-right-column[
<br>
  #### Runtime Patterns
  `Mount Sources`
<br><br>
  `Docker Socket Mount`
<br><br>
  `Containers Launcher`
<br><br>
  `Build From Scratch`
<br><br>
  `Host Spoofing`
<br><br>
  `ENTRYPOINT and CMD combined`
<br><br>
  `Exec Form ENTRYPOINT`
]

---

template: inverse

## Copy Sources
A development pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]
  ## CS
  ### Pattern
]
.right-column[
.center[![cp-CS](images/cp-CS.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ### Pattern
]
.right-column[
## Copy Sources ![Docker](images/docker.png)
- development pattern
- Sources are copied inside the image
- Simplest development pattern
- A new image should be built for every code change
- Build tools are included in the image
- Usually a different image is used to run the application
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ### Pattern
  ### Example
]
.right-column[
## Copy 2048 ![Docker](images/docker.png)
**Docker Image**<br>2048

**Source code**<br>https://github/l0rd/containerspatterns/CS/

**Build and run commands**
```bash
docker build -t 2048  .
docker run -d -p 8080:80 2048
```
]


???
In this pattern it's particularly important to separate in 2 distinct steps:
- fetching the dependencies
- build of the application




---

template: inverse

## Mount Sources
A development and runtime pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
## MS
  ### Pattern
]
.right-column[
  .center[![cp-MS](images/cp-MS.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
## MS
  ### Pattern
]
.right-column[
## Mount Sources ![Docker](images/docker-mini.png)

- Development and Runtime Pattern
- Source folder is bind mounted when running the container
- Pattern particularly suited for dynamic languages
- Not recommended for production
- No need to rebuild or restart container when sources are updated
- Build tools are included in the image
- The same image can be used to compile and run the application
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
## MS
  ### Pattern
  ### Example
]
.right-column[
## Mount 2048 ![Docker](images/docker-mini.png)

**Docker Image**<br>2048

**Source code**<br>https://github/l0rd/containerspatterns/MS/

**Build and run command**
```bash
docker build -t 2048 .
docker run -p 8080:80 \
           -v $(pwd):/usr/local/apache2/htdocs/ \
           2048
```
]

---

template: inverse

## Dockerize Your Tools
A development pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ## MS
## DYT
  ### Pattern
]
.right-column[
.center[![cp-DYT](images/cp-DYT.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ## MS
## DYT
  ### Pattern
]
.right-column[
## Dockerize Your Tools ![Docker](images/docker-mini.png)
- Development pattern
- A tool is packaged and distributed as a Docker image
- Allow to run multiple versions of the same tool
- The tool version and installation is described in a Dockerfile
- Files can be shared between the container and the host with volumes
- `alias` command can be used to make it easier to run
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ## MS
## DYT
  ### Pattern
  ### Example
]
.right-column[
## Dockerize maven ![Docker](images/docker-mini.png)

**Docker Image**<br>maven:3.3.3-jdk-8

**Source code**<br>https://github/l0rd/containerspatterns/DYT

**Run command**
```bash
# Make the alias of the dockerized tool
alias mvn="docker run \
   -v $(pwd):/usr/src \
   -v ~/.m2:/root/.m2 \
   -w /usr/src  \
   maven:3.3.3-jdk-8 \
   mvn"

# Run the tool
mvn -version
```
]

---

template: inverse

## Docker Socket Mount 
A runtime pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ## MS
  ## DYT
## DSM
  ### Pattern
]
.right-column[
<br><br>
.center[![cp-DSM](images/cp-DSM.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ## MS
  ## DYT
## DSM
  ### Pattern
]
.right-column[
## Docker Socket Mount ![Docker](images/docker-mini.png)
- Runtime Pattern
- The Docker socket is bind mounted when the container is started
- Allow to manage containers from another container
- Usages:
  - Container monitoring tools
  - CI/CD tools
  - Containers launchers
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## CS
  ## MS
  ## DYT
## DSM
  ### Pattern
  ### Example
]
.right-column[
## Docker Socket Mount ![Docker](images/docker-mini.png) ![Docker](images/golang-logo-mini.png)

**Docker Image**<br>containerslanguages/golang

**Source code**<br>https://github/l0rd/containerspatterns/DSM

**Run command**
```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock \
        containerslanguages/golang
```
]

---

template: inverse

## Containers Launcher
A Distribution and runtime pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## DYT
  ## DSM
## CL  
  ### Pattern
]
.right-column[
.center[![cp-CL](images/cp-CL.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## DYT
  ## DSM
## CL  
  ### Pattern
]
.right-column[
## Containers Launcher ![Docker](images/docker-mini.png)
- Runtime Pattern
- The Docker socket is bind mounted when the container is started
- Use to compose multiple containers without Docker compose or similar
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## DYT
  ## DSM
## CL  
  ### Pattern
  ### Example
]
.right-column[
## Containers launcher ![Docker](images/docker-mini.png)

**Docker Image**<br>containerslanguages/rust-launcher

**Source code**<br>https://github/l0rd/containerspatterns/CL

**Run command**
```bash
docker run -v $(pwd):/src/ \
        -v /var/run/docker.sock:/var/run/docker.sock \
        containerslanguages/rust-launcher
```
]

---

template: inverse

## Build From Scratch
A Distribution and runtime pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## DSM
  ## CL
## BFS  
  ### Pattern
]
.right-column[
<br><br>
.center[![cp-BFS](images/cp-BFS.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## DSM
  ## CL
## BFS  
  ### Pattern
]
.right-column[
## Build From Scratch ![Docker](images/docker-mini.png)
- Distribution and Runtime Pattern
- The base image is the smallest possible: `Scratch`
- Use to make ridiculously small images
- Works well with statically linked applications (Go, Rust, C etc...)
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## DSM
  ## CL
## BFS  
  ### Pattern
  ### Example
]
.right-column[
## Go HTTP server built from scratch ![Docker](images/docker-mini.png) ![Docker](images/golang-logo-mini.png)

**Docker Image**<br>emilevauge/tictac

**Source code**<br>https://github/emilevauge/tictac/

**Run command**
```bash
docker build -t tictac .
# Compare tictac binary size with tictac docker image size
```
]

---

template: inverse

## Host Spoofing
A runtime pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## CL
  ## BFS
## HS  
  ### Pattern
]
.right-column[
<br><br>
.center[![cp-HS](images/cp-HS.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## CL
  ## BFS
## HS  
  ### Pattern
]
.right-column[
## Host Spoofing ![Docker](images/docker-mini.png)
- Runtime Pattern
- Run commands inside a container to inspect or alter the Docker host
- Access to host network, filesystem, processes, users etc...
- Break container isolation
- Won't work when security hardening the Docker install
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## CL
  ## BFS
## HS  
  ### Pattern
  ### Example
]
.right-column[
## Get host info from a container ![Docker](images/docker-mini.png)

**Docker Image**<br>alpine

**Source code**<br>https://github/l0rd/containerspatterns/HS

**Run command**
```bash
docker run --net=host                               \
           -v /:/hostfs/                            \
           --pid=host                               \
           --uts=host                               \
           --ipc=host                               \
           -v $(pwd):/src/                          \
           alpine sh -c ". /src/print_host_info.sh"
```
]

---

template: inverse

## ENTRYPOINT and CMD Combined
A runtime pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## BFS
  ## HS
## ECC  
  ### Pattern
]
.right-column[
<br><br>
.center[![cp-ECC](images/cp-ECC.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## BFS
  ## HS
## ECC  
  ### Pattern
]
.right-column[
## ENTRYPOINT and CMD Combined ![Docker](images/docker-mini.png)
- Runtime Pattern
- Instructions ENTRYPOINT and CMD are used together
- ENTRYPOINT is the fixed part of the command
- CMD is the variable part (usually the parameters)
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## BFS
  ## HS
## ECC  
  ### Pattern
  ### Example
]
.right-column[
## Asciiart generator with ENTRYPOINT and CMD ![Docker](images/docker-mini.png)

**Docker Image**<br>ecc

**Source code**<br>https://github/l0rd/containerspatterns/ECC

**Run command**
```bash
docker run -ti --rm ecc
docker run -ti --rm ecc -f lean docker
```
]

---

template: inverse

## Exec Form ENTRYPOINT
A runtime pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## BFS
  ## HS
## EFE  
  ### Pattern
]
.right-column[
<br><br>
.center[![cp-EFE](images/cp-EFE.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## BFS
  ## HS
## EFE  
  ### Pattern
]
.right-column[
## Exec Form ENTRYPOINT ![Docker](images/docker-mini.png)
- Runtime Pattern
- JSON is used to define the command and its parameters
- It's the alternative to the Shell Form (`/bin/sh -c` on Linux or `cmd /S /C` on Windows)
- No varialbe substitution and the command is PID 1
- Unix signals are notified directly to the program (not the shell)
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## BFS
  ## HS
## EFE  
  ### Pattern
  ### Example
]
.right-column[
## `Exec` and `Shell` form compared ![Docker](images/docker-mini.png)

**Docker Image**<br>httpd

**Source code**<br>https://github/l0rd/containerspatterns/EFE/

**Build and Run commands**
```bash
docker build -t httpd-exec -f Dockerfile.exec .
docker build -t httpd-shell -f Dockerfile.shell .

docker run -i -P --rm httpd-exec
# Stop it using ^C
docker run -i -P --rm httpd-shell
# (Try to) stop it using ^C
```
]

---

template: inverse

## ONBUILD Images
A development pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## HS
  ## EFE
## OBI  
  ### Pattern
]
.right-column[
<br><br>
.center[![cp-OBI](images/cp-OBI.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## HS
  ## EFE
## OBI  
  ### Pattern
]
.right-column[
## ONBUILD Images ![Docker](images/docker-mini.png)
- Development pattern
- Build behaviour inherited from base image
- Avoid duplicate code in Dockerfiles
- Can make Dockerfile difficult to read
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## HS
  ## EFE
## OBI  
  ### Pattern
  ### Example
]
.right-column[
## Build a Java app with ONBUILD ![Docker](images/docker-mini.png)

**Docker Image**<br>obi-java

**Source code**<br>https://github/l0rd/containerspatterns/OBI

**Build/Run commands**
```bash
docker build -t obi-java .
docker run --rm obi-java
```
]

---

template: inverse

## Dependencies First Dockerfile
A development pattern

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## HS
  ## EFE
## DFD  
  ### Pattern
]
.right-column[
.center[![cp-DFD](images/cp-DFD.png)]
]

---

.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## HS
  ## EFE
## DFD  
  ### Pattern
]
.right-column[
## Dependencies First Dockerfile ![Docker](images/docker-mini.png)
- Development pattern
- Dependencies should not be fetched at every change in source code
- In Dockerfile dependency list should be copied before source code
]

---
.left-column[
.footnote[@hguemar, @mariolet, @mjbright ]

  ## ...
  ## HS
  ## EFE
## DFD  
  ### Pattern
  ### Example
]
.right-column[
## Packaging a python application with Docker ![Docker](images/docker-mini.png)

**Docker Image** dfd

**Source code**<br>https://github/l0rd/containerspatterns/dfd
<br>https://github/polyfunc/flask-todolist

**Build command**
```bash
docker build -t dfd .
docker build -t dfd-orig -f Dockerfile.orig .

touch onefile

docker build -t dfd .
docker build -t dfd-orig -f Dockerfile.orig .
```
]

---

template: inverse

## Conclusion

---

class: center
.footnote[@hguemar, @mariolet, @mjbright ]

![cp-periodic-table](images/cp-PeriodicTable.png)

---

template: inverse

## Thank you

https://containerslanguages.github.io/

[@hguemar, @mariolet, @mjbright]
