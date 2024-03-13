# Use an official Tomcat image as a base
FROM tomcat:9.0-jdk11-openjdk-slim AS deploy

# Remove the default Tomcat webapps directory
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the local filesystem to the webapps directory in the container
COPY Aaptatt-hiring-assignment/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port the Tomcat server runs on
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
