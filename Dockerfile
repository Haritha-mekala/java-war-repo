FROM maven:3.8.5-openjdk-17 AS builder 
WORKDIR /opt
RUN git clone https://github.com/Haritha-mekala/java-war-repo.git
WORKDIR /opt/java-war-repo
RUN mvn clean package 
FROM tomcat:10.1-jdk17 
WORKDIR /usr/local/tomcat/webapps/ 
COPY --from=builder /ops-app/target/*.war opskill.war 
EXPOSE 8080 
CMD ["catalina.sh", "run"] 
