# Build the Java App
FROM maven:3.5-jdk-8 as BUILD_IMAGE
COPY src /usr/src/s2i/src
COPY pom.xml /usr/src/s2i
RUN mvn -f /usr/src/s2i/pom.xml clean compile assembly:single

# Package the Java App
FROM openjdk:8-jre
WORKDIR /root/
COPY --from=BUILD_IMAGE /usr/src/s2i/target/s2i-1.0.0-SNAPSHOT.jar .
ENTRYPOINT ["java","-jar","s2i-1.0.0-SNAPSHOT.jar"]