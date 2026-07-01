#!/bin/bash

echo "Deploying ntfy configuration..."

# 1. Ensure the destination directory exists
mkdir -p ~/.config/ntfy

# 2. Fetch the secrets securely from Bitwarden/rbw
# (Make sure the item names match what is in your vault)
export NTFY_USER=$(rbw get ntfy --field user)
export NTFY_TOKEN=$(rbw get ntfy --field prometheus)

# 3. Inject ONLY the specific secrets, protecting $title, $message, etc.
envsubst '${NTFY_USER} ${NTFY_TOKEN}' < ~/.dotfiles/ntfy/client.yml.template > ~/.config/ntfy/client.yml

echo "Deployment complete!"
