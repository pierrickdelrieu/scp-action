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



# Create an SSH key file
mkdir -p $HOME/.ssh
echo "$SSH_KEY" > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

# Create a passphrase file
echo "$SSH_PASSPHRASE" > $HOME/.ssh/passphrase

# Add the key with passphrase to the SSH agent
eval $(ssh-agent -s)
ssh-add $HOME/.ssh/id_rsa < $HOME/.ssh/passphrase



# Check if the remove flag is set
if [ "${REMOVE_DIR}" = true ]; then
    ssh -p "${SSH_PORT}" -i "${SSH_KEY}" -o "StrictHostKeyChecking=no" "${SSH_USERNAME}@${HOST}" "rm -rf ${DESTINATION_DIR}"
fi



scp -i $HOME/.ssh/id_rsa -P "${SSH_PORT}" -o StrictHostKeyChecking=no -r "$GITHUB_WORKSPACE/${SOURCE_DIR}/" "${SSH_USERNAME}@${HOST}:${DESTINATION_DIR}"

