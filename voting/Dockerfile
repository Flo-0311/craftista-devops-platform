FROM maven:3-eclipse-temurin-19-alpine as build
WORKDIR /app
COPY . .
RUN mvn package

FROM eclipse-temurin:19-jdk
WORKDIR /app
COPY --from=build /app/target/voting-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
