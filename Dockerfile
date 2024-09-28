# Use a slim version of Tomcat for smaller image size
FROM tomcat:10.1-jdk21-slim

# Set the working directory
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file into the Tomcat webapps directory
COPY target/demo-application-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/demo-application.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
