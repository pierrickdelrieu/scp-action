#!/bin/sh

# Variables d'entrée
SOURCE_DIR="${INPUT_SOURCE_DIR}"
DESTINATION_SERVER="${INPUT_DESTINATION_SERVER}"
DESTINATION_DIR="${INPUT_DESTINATION_DIR}"
SSH_KEY="${INPUT_SSH_KEY}"
PASSPHRASE="${INPUT_PASSPHRASE}"


# Prepare options for SCP command
SCP_OPTIONS="-i $SSH_KEY"

# Add passphrase to the SCP options if provided
if [ -n "$PASSPHRASE" ]; then
  SCP_OPTIONS="$SCP_OPTIONS -o 'PreferredAuthentications=publickey' -o 'PasswordAuthentication=no' -o 'IdentitiesOnly=yes'"
  export SSH_PASSPHRASE="$PASSPHRASE"
fi

# Check if the -rm option is set
# if [ "$REMOVE_EXISTING" = "true" ]; then
  # Remove existing files on the remote server
 # ssh $SCP_OPTIONS -o "BatchMode yes" "$DESTINATION_SERVER" "rm -rf $DESTINATION_DIR/*"
# fi


# Utiliser SCP pour copier le contenu du dossier source vers le serveur distant
scp -i "$SSH_KEY" -r "$SOURCE_DIR" "$DESTINATION_SERVER:$DESTINATION_DIR"
