# Use the official Gradle image
FROM gradle:7.5-jdk11 AS build

# Set the working directory
WORKDIR /app

# Copy the Gradle files
COPY build.gradle settings.gradle ./
COPY src ./src

# Build the application
RUN gradle build --no-daemon

# Use a smaller image for the final run
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/build/libs/my-java-app-1.0-SNAPSHOT.jar app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
