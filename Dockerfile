FROM tomcat:10.1-jdk21

WORKDIR /usr/local/tomcat/webapps/

COPY target/demo-application-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/demo-application.war

EXPOSE 8000

CMD ["catalina.sh", "run"]
