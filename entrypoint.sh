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
if [ "${REMOVE_TARGET}" = true ]; then
    ssh -p "${PORT}" -i "${KEY}" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" "${USERNAME}@${HOST}" "rm -rf ${DESTINATION_DIR}"
fi

# Copy files to the remote server
scp -P "${PORT}" -i "${KEY}" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -r "${SOURCE_DIR}" "${USERNAME}@${HOST}:${DESTINATION_DIR}"
