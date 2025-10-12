FROM jenkins/ssh-agent:latest-debian-jdk21

ARG ROOT_PASSWORD
ARG JENKINS_USER_PASSWORD

ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt update && \
    apt upgrade -y && \
    apt-get install -y sudo && \
    usermod -aG sudo jenkins

RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "root:${ROOT_PASSWORD}" | chpasswd
RUN echo "jenkins:${JENKINS_USER_PASSWORD}" | chpasswd

USER jenkins

# Now the base platform created only need to install the dependencies.


RUN sudo apt install -y curl

USER root

