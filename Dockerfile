FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn package -DskipTests

FROM openjdk:8-alpine
EXPOSE 8080
COPY --from=MAVEN_BUILD /build/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]