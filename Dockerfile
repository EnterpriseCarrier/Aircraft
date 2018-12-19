FROM openjdk:8-jdk

MAINTAINER Xu Zhang
RUN apt-get update && apt-get upgrade -y && apt-get clean

WORKDIR /
RUN mkdir -p /EnterpriseCarrier/FlightDeck/Aircraft
COPY applications/ /EnterpriseCarrier/FlightDeck/Aircraft/applications/
COPY build/ /EnterpriseCarrier/FlightDeck/Aircraft/build/
COPY framework/ /EnterpriseCarrier/FlightDeck/Aircraft/framework/
COPY gradle/ /EnterpriseCarrier/FlightDeck/Aircraft/gradle/
COPY hot-deploy/ /EnterpriseCarrier/FlightDeck/Aircraft/hot-deploy/
COPY lib/ /EnterpriseCarrier/FlightDeck/Aircraft/lib/
COPY runtime/ /EnterpriseCarrier/FlightDeck/Aircraft/runtime/
COPY specialpurpose /EnterpriseCarrier/FlightDeck/Aircraft/specialpurpose/
COPY themes/ /EnterpriseCarrier/FlightDeck/Aircraft/themes/
COPY tools/ /EnterpriseCarrier/FlightDeck/Aircraft/tools/
COPY *.gradle /EnterpriseCarrier/FlightDeck/Aircraft/
COPY Dockerfile /EnterpriseCarrier/FlightDeck/Aircraft/ 
COPY gradlew /EnterpriseCarrier/FlightDeck/Aircraft/
COPY README.md /EnterpriseCarrier/FlightDeck/Aircraft/
COPY README.md.html /EnterpriseCarrier/FlightDeck/Aircraft/

# compile
WORKDIR /EnterpriseCarrier/FlightDeck/Aircraft/

# set default 2G memory for OFBiz. 
ENV JAVA_OPTS -Xmx2G 

# build and load demo data
RUN ./gradlew cleanAll loadDefault

##for passing in entity engine config - maybe replace with copy?
VOLUME /EnterpriseCarrier/FlightDeck/Aircraft/framework/entity/config/

##for Derby Database
VOLUME /EnterpriseCarrier/FlightDeck/Aircraft/runtime/data

EXPOSE 8443 8080

ENTRYPOINT ./gradlew ofbiz