FROM maven:3.5-jdk-8
VOLUME /tmp
ADD target/auth-2.1.1.RELEASE.war auth-2.1.1.RELEASE.war
EXPOSE 8081
ENTRYPOINT ["java","-jar","auth-2.1.1.RELEASE.war"]
