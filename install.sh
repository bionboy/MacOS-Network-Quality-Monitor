#!/bin/bash

# Define variables
PLIST_SRC="./com.user.networkQualityReport.plist"
PLIST_DEST="$HOME/Library/LaunchAgents/com.user.networkQualityReport.plist"

# Copy the plist file
cp "$PLIST_SRC" "$PLIST_DEST"

# Set correct permissions
chmod 644 "$PLIST_DEST"

# Load the plist file (for the current user)
launchctl load -w "$PLIST_DEST"

echo "Installation and loading of plist complete."
