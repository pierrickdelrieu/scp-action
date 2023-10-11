#!/bin/sh

# Inputs from the action.yaml file
HOST="$INPUT_HOST"
SSH_PORT="$INPUT_SSH_PORT"
SSH_USERNAME="$INPUT_SSH_USERNAME"
SSH_KEY="$INPUT_SSH_KEY"
SSH_PASSPHRASE="$INPUT_SSH_PASSPHRASE"
SOURCE_DIR="$INPUT_SOURCE_DIR"
DESTINATION_DIR="$INPUT_DESTINATION_DIR"
REMOVE_DIR="$INPUT_RM"



# Check if the remove flag is set
#if [ "${REMOVE_TARGET}" = true ]; then
#    ssh -p "${SSH_PORT}" -i "${SSH_KEY}" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" "${SSH_USERNAME}@${HOST}" "rm -rf ${DESTINATION_DIR}"
#fi


# Create an SSH key file with the provided key and passphrase
mkdir -p $HOME/.ssh
echo "$SSH_KEY" > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa


# Add passphrase to the SSH agent
#if [ -n "$SSH_PASSPHRASE" ]; then
#  echo "$SSH_PASSPHRASE" | ssh-add -
#fi
#echo $HOME/.ssh/id_rsa
#echo "$GITHUB_WORKSPACE/${SOURCE_DIR}"
#echo $GITHUB_WORKSPACE/${SOURCE_DIR}/file1.txt


# Copy files to the remote server
#sshpass -p /root/ssh_passphrase scp -P "${SSH_PORT}" -i /root/ssh_key -o StrictHostKeyChecking=no -o ConnectTimeout=30 -o ServerAliveInterval=30 -r "$GITHUB_WORKSPACE/${SOURCE_DIR}" "${SSH_USERNAME}@${HOST}:${DESTINATION_DIR}"
#sshpass -p ${SSH_PASSPHRASE} scp -P "${SSH_PORT}" -i /root/ssh_key -o StrictHostKeyChecking=no -o ConnectTimeout=30 -o ServerAliveInterval=30 -r "$GITHUB_WORKSPACE/${SOURCE_DIR}" "${SSH_USERNAME}@${HOST}:${DESTINATION_DIR}"
#sshpass -p "${SSH_PASSPHRASE}" scp -i $HOME/.ssh/id_rsa -P "${SSH_PORT}" -o StrictHostKeyChecking=no -o ConnectTimeout=30 -o ServerAliveInterval=30 -r "$GITHUB_WORKSPACE/${SOURCE_DIR}" "${SSH_USERNAME}@${HOST}:${DESTINATION_DIR}"



# Create an SSH key file
echo "$SSH_KEY" > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

# Create a passphrase file
echo "$SSH_PASSPHRASE" > $HOME/.ssh/passphrase

# Add the key with passphrase to the SSH agent
eval $(ssh-agent -s)
ssh-add $HOME/.ssh/id_rsa < $HOME/.ssh/passphrase
scp -i $HOME/.ssh/id_rsa -P "${SSH_PORT}" -o StrictHostKeyChecking=no -r "$GITHUB_WORKSPACE/${SOURCE_DIR}" "${SSH_USERNAME}@${HOST}:${DESTINATION_DIR}"

