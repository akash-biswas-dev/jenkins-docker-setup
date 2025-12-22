FROM jenkins/ssh-agent:latest-debian-jdk21

WORKDIR /temp

RUN apt-get update

RUN apt-get install -y curl 

RUN curl -o apache-maven.tar.gz \
    https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz

RUN mkdir maven && tar -xzvf apache-maven.tar.gz -C maven --strip-components=1

RUN mv maven /usr/local/

WORKDIR /usr/bin

RUN ln -s /usr/local/maven/bin/mvn mvn

ENTRYPOINT ["setup-sshd"]


