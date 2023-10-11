#!/bin/sh

# Variables d'entrée
SOURCE_DIR="${INPUT_SOURCE_DIR}"
DESTINATION_SERVER="${INPUT_DESTINATION_SERVER}"
DESTINATION_DIR="${INPUT_DESTINATION_DIR}"
SSH_KEY="${INPUT_SSH_KEY}"
PASSPHRASE="${INPUT_PASSPHRASE"

# Supprimer le contenu du dossier de destination sur le serveur distant
ssh -i "$SSH_KEY" "$DESTINATION_SERVER" "rm -rf $DESTINATION_DIR/*"

# Copier le contenu du dossier source vers le serveur distant
rsync -avz -e "ssh -i $SSH_KEY" "$SOURCE_DIR/" "$DESTINATION_SERVER:$DESTINATION_DIR/"
