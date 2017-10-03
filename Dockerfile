FROM ubuntu:latest
MAINTAINER Umberto Rosini, rosini@agid.gov.it

RUN apt-get update

# Create user to run wso2 and the backoffice (not root for security reason!)
RUN useradd --user-group --shell /bin/false yoda

# Oracle Java 8
RUN apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get install oracle-java8-set-default && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# Identity Server
RUN apt-get install curl && \
    mkdir /spid-testenv && \
    curl -o /spid-testenv/spid-testenv-identityserver.tar.gz https://codeload.github.com/italia/spid-testenv-identityserver/tar.gz/v0.9-beta.1 && \
    mkdir /spid-testenv/is && \
    tar -zxvf /spid-testenv/spid-testenv-identityserver.tar.gz -C /spid-testenv/is --strip-components=1 && \
    rm -f /spid-testenv/spid-testenv-identityserver.tar.gz && \
    chmod +x /spid-testenv/is/identity-server/bin/wso2server.sh

# Set custom conf
RUN mv /spid-testenv/is/spid-conf/conf/* /spid-testenv/is/identity-server/repository/conf/ 
    #./spid-testenv/is/identity-server/bin/wso2server.sh
    
