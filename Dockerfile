# First stage: Build the application using Maven 3.9.9 with Java 21
FROM maven:3.9.9-eclipse-temurin-21 AS builder

# Copy the pom.xml and source code into the container
COPY pom.xml .
COPY src ./src


# Package the application, skipping tests
RUN mvn clean package

# Set the working directory
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file into the Tomcat webapps directory
COPY target/demo-application-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/demo-application.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

