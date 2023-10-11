FROM alpine:latest

# Install SSH and SCP client
RUN apk add openssh-client sshpass

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
