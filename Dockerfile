FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/task-api-0.0.1-SNAPSHOT.jar app.jar
ENV SPRING_DATA_MONGODB_URI=mongodb://mongodb-service:27017/taskdb
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]