FROM docker:29.0.0-rc.2-dind

ARG ROOT_PASSWORD
ARG JENKINS_USER_PASSWORD


USER root

RUN apk update &&  \
    apk upgrade --no-cache -a

RUN apk add --no-cache  \
    sudo \
    shadow \
    curl \
    openjdk21 \
    openssh

RUN addgroup sudo


RUN adduser jenkins -D && \
    usermod -aG sudo jenkins && \
    usermod -aG docker jenkins

RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "root:${ROOT_PASSWORD}" | chpasswd
RUN echo "jenkins:${JENKINS_USER_PASSWORD}" | chpasswd

RUN ssh-keygen -A && \
    mkdir -p /home/jenkins/.ssh


# Till this point install and setup the dependencies in the image.
CMD ["/bin/sh", "-c", "\
  if [ -n \"$JENKINS_PUBLIC_KEY\" ]; then \
    echo \"$JENKINS_PUBLIC_KEY\" > /home/jenkins/.ssh/authorized_keys && \
    chown jenkins:jenkins /home/jenkins/.ssh/authorized_keys && \
    chmod 600 /home/jenkins/.ssh/authorized_keys; \
  fi && \
  /usr/local/bin/dockerd-entrypoint.sh & \
  /usr/sbin/sshd -D"]


