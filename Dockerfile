# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
VOLUME /tmp

COPY --from=build /app/target/*.jar config-server.jar

EXPOSE 8888
ENTRYPOINT ["java", "-jar", "/app/config-server.jar"]
