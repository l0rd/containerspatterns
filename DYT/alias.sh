#!/bin/bash

alias mvndock="docker run \
   -v $(pwd):/usr/src \
   -v ~/.m2:/root/.m2 \
   -w /usr/src  \
   maven:3.3.3-jdk-8 \
   mvn"

# mvndock -version
# mvn version

# mvndock clean install
# java -cp target/fizz-buzz-1.0-SNAPSHOT.jar com.github.containerspatterns.App 