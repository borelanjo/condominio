FROM maven:3.6.3-openjdk-15-slim AS MAVEN_BUILD
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn package -DskipTests

FROM openjdk:15-alpine
EXPOSE 8080
COPY --from=MAVEN_BUILD /build/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]