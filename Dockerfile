FROM gradle:8.5-jdk17 AS build

WORKDIR /app

COPY build.gradle ./
COPY gradle ./gradle
COPY gradlew ./
COPY src ./src

RUN gradle build --no-daemon -x test

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]