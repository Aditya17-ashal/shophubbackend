FROM maven:3.8.3-openjdk-24 AS build
COPY . .
RUN mvn clean install

FROM eclipse-temurn:24-jdk
COPY --from=build /target/familyhub-0.0.1-SNAPSHOT.jar Demo.jar
EXPOSE 8082
ENTRYPOINT["java","-jar","demo.jar"]