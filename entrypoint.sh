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


# Prepare options for SCP command
SCP_OPTIONS="-i $SSH_KEY -p "$SSH_PORT""


# Check if the remove flag is set
#if [ "${REMOVE_TARGET}" = true ]; then
#    ssh -p "${SSH_PORT}" -i "${SSH_KEY}" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" "${SSH_USERNAME}@${HOST}" "rm -rf ${DESTINATION_DIR}"
#fi


#echo "$SSH_KEY" > /root/ssh_key
#chmod 600 /root/ssh_key
#echo "$SSH_PASSPHRASE" > /root/ssh_passphrase
#chmod 600 /root/ssh_passphrase


# Copy files to the remote server
#sshpass -p /root/ssh_passphrase scp -P "${SSH_PORT}" -i /root/ssh_key -o StrictHostKeyChecking=no -o ConnectTimeout=30 -o ServerAliveInterval=30 -r "$GITHUB_WORKSPACE/${SOURCE_DIR}" "${SSH_USERNAME}@${HOST}:${DESTINATION_DIR}"
sshpass -p "${SSH_PASSPHRASE}" scp -P "${SSH_PORT}" -i "${SSH_KEY}" -o StrictHostKeyChecking=no -o ConnectTimeout=30 -o ServerAliveInterval=30 -r "$GITHUB_WORKSPACE/${SOURCE_DIR}" "${SSH_USERNAME}@${HOST}:${DESTINATION_DIR}"

