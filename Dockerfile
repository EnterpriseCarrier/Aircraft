FROM openjdk:8-jdk

# todo create a new user and add it to a group
# RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

MAINTAINER Xu Zhang
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir -p /EnterpriseCarrier/FlightDeck/Aircraft
WORKDIR /EnterpriseCarrier/FlightDeck/Aircraft/

# Copy all source code for image building
COPY ./ ./

# Set default 2G memory for OFBiz.
ENV JAVA_OPTS -Xmx2G 

# Build and load demo data
RUN ./gradlew cleanAll loadDefault

EXPOSE 8080 8443

# todo switch to the user for process execution
# USER uwsgi

ENTRYPOINT ./gradlew ofbiz