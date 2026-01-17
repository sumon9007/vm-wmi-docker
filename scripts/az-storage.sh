#!/bin/bash

# Path to the configuration file
CONFIG_FILE="$(dirname "$0")/../config/.env"

# Check if config file exists
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: Configuration file not found at $CONFIG_FILE"
    exit 1
fi

# Check variables
if [ -z "$AZ_STORAGE_ACCOUNT" ] || [ -z "$AZ_STORAGE_KEY" ] || [ -z "$AZ_SHARE_NAME" ]; then
    echo "Error: One or more required variables (AZ_STORAGE_ACCOUNT, AZ_STORAGE_KEY, AZ_SHARE_NAME) are invalid or empty."
    exit 1
fi

# Set mount point (default to /mnt/data if not provided)
MOUNT_POINT=${1:-"/mnt/data"}

# Create mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point: $MOUNT_POINT"
    sudo mkdir -p "$MOUNT_POINT"
fi

# URL for the Azure file share
SHARE_URL="//${AZ_STORAGE_ACCOUNT}.file.core.windows.net/${AZ_SHARE_NAME}"

echo "Mounting $SHARE_URL to $MOUNT_POINT..."

# Mount command
sudo mount -t cifs "$SHARE_URL" "$MOUNT_POINT" \
    -o vers=3.0,username="$AZ_STORAGE_ACCOUNT",password="$AZ_STORAGE_KEY",dir_mode=0777,file_mode=0777,serverino

if [ $? -eq 0 ]; then
    echo "Successfully mounted $AZ_SHARE_NAME at $MOUNT_POINT"
else
    echo "Failed to mount Azure file share."
    exit 1
fi
