#!/bin/bash

# Configuration
CONFIG_FILE="$(dirname "$0")/../config/.env"
CRED_DIR="/etc/smbcredentials"
CRED_FILE="$CRED_DIR/azstorage.cred"
FSTAB_FILE="/etc/fstab"

# Check if config file exists
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: Configuration file not found at $CONFIG_FILE"
    exit 1
fi

# Check variables
if [ -z "$AZ_STORAGE_ACCOUNT" ] || [ -z "$AZ_STORAGE_KEY" ] || [ -z "$AZ_SHARE_NAME" ]; then
    echo "Error: One or more required variables are invalid or empty."
    exit 1
fi

# 1. Create Credentials File
echo "Setting up credentials..."
if [ ! -d "$CRED_DIR" ]; then
    sudo mkdir -p "$CRED_DIR"
fi

if [ ! -f "$CRED_FILE" ]; then
    echo "username=$AZ_STORAGE_ACCOUNT" | sudo tee "$CRED_FILE" > /dev/null
    echo "password=$AZ_STORAGE_KEY" | sudo tee -a "$CRED_FILE" > /dev/null
    sudo chmod 600 "$CRED_FILE"
    echo "Credentials file created at $CRED_FILE"
else
    echo "Credentials file already exists at $CRED_FILE"
fi

# 2. Backup fstab
echo "Backing up fstab..."
sudo cp "$FSTAB_FILE" "${FSTAB_FILE}.bak.$(date +%Y%m%d%H%M%S)"

# 3. Add to fstab
MOUNT_POINT="/mnt/data"
SHARE_URL="//${AZ_STORAGE_ACCOUNT}.file.core.windows.net/${AZ_SHARE_NAME}"
FSTAB_ENTRY="$SHARE_URL $MOUNT_POINT cifs credentials=$CRED_FILE,dir_mode=0777,file_mode=0777,serverino,nofail,vers=3.0 0 0"

if grep -qF "$SHARE_URL" "$FSTAB_FILE"; then
    echo "Entry for $SHARE_URL already exists in $FSTAB_FILE"
else
    echo "Adding entry to $FSTAB_FILE..."
    echo "$FSTAB_ENTRY" | sudo tee -a "$FSTAB_FILE" > /dev/null
    echo "Successfully added to fstab."
fi

# 4. Reload and Mount
echo "Reloading systemd daemon and mounting..."
sudo systemctl daemon-reload
sudo mount -a

if mount | grep -q "$MOUNT_POINT"; then
    echo "Success: $MOUNT_POINT is mounted."
else
    echo "Warning: Mount check failed. Please check 'sudo mount -a' output."
fi
