FROM fabioluciano/alpine-base-java
LABEL Maintainer="Fábio Luciano <fabioluciano@php.net>" \
  Description="Alpine Java SSH"

WORKDIR /opt

COPY files/supervisor/* /etc/supervisor.d/

## Configure SSH
RUN apk --update --no-cache add openssh \
  && printf "password\npassword" | adduser app \
  && printf "\n\n" | ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
  && printf "\n\n" | ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key \
  && printf "\n\n" | ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
  && printf "\n\n" | ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key \
  && echo "AllowUsers app" >> /etc/ssh/sshd_config \
  && rm -rf /var/cache/apk/*

EXPOSE 22/tcp 8080/tcp 8443/tcp
