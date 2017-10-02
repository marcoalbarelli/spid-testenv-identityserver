FROM ubuntu:16.04
MAINTAINER Umberto Rosini, rosini@agid.gov.it

RUN apt-get update

# Oracle Java 8
RUN apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get install oracle-java8-set-default && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# untar wso2-is in /opt/wso2-is
#RUN mkdir /otp/spid-testenv && \
#    curl -o /opt/spid-testenv/spid-testenv-identityserver.tar.gz https://codeload.github.com/italia/spid-testenv-identityserver/tar.gz/0.9-beta.1 && \
#    mkdir /opt/spid-testenv/identityserver && \
#    tar -zxvf /opt/spid-testenv/spid-testenv-identityserver.tar.gz -C /opt/spid-testenv/identityserver --strip-components=1 && \
#    rm -f /opt/spid-testenv/spid-testenv-identityserver.tar.gz && \
#    chmod +x /opt/spid-testenv/identity-server/identity-server/bin/wso2server.sh
    
# Port exposed
EXPOSE 9443

WORKDIR /opt/spid-testenv/identity-server

#ENTRYPOINT ["identity-server/bin/wso2server.sh"]
