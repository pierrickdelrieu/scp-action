FROM ubuntu:latest

RUN apt-get update && apt-get install -y sshpass openssh-client

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

