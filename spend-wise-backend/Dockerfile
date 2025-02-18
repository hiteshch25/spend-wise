# Use OpenJDK 17 as the base image
FROM openjdk:21

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/FamilyCashCard-0.0.1-SNAPSHOT.jar /app/FamilyCashCard-0.0.1-SNAPSHOT.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "FamilyCashCard-0.0.1-SNAPSHOT.jar"]
