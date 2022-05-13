FROM ubuntu:22.04

LABEL website="sangchul.kr"

ARG DEBIAN_FRONTEND=noninteractive
ARG SSH_USER=${SSH_USER:-ubuntu}
ARG SSH_PASSWORD=${SSH_PASSWORD:-ubuntu}

ENV TZ=Asia/Seoul
ENV SSH_USER=${SSH_USER}
ENV SSH_PASSWORD=${SSH_PASSWORD}
ENV PS1A="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "

RUN echo $TZ > /etc/timezone

RUN apt update \
    && apt upgrade -qq -y \
    && apt install -qq -y openssh-server \
        aptitude sudo ssh vim curl \
        net-tools iputils-ping traceroute netcat telnet dnsutils \
    && mkdir /var/run/sshd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER root

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
#RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

RUN mkdir -m 700 ~/.ssh \
    && echo 'PS1=$PS1A' >> ~/.bashrc \
    && echo "alias ll='ls -lha'" >> ~/.bashrc \
    && echo "root:root" | chpasswd

RUN useradd -c "System Administrator" -m -d /home/$SSH_USER -s /bin/bash $SSH_USER \
    && usermod -aG sudo $SSH_USER \
    && echo 'PS1=$PS1A' >> /home/$SSH_USER/.bashrc \
    && echo "alias ll='ls -lha'" >> /home/$SSH_USER/.bashrc \
    && mkdir -m 700 /home/$SSH_USER/.ssh \
    && chown $SSH_USER.$SSH_USER /home/$SSH_USER/.ssh \
    && echo "$SSH_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

EXPOSE 22

# CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
