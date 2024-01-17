#!/bin/bash

launch_agent_path="$HOME/Library/LaunchAgents/com.user.networkQualityReport.plist"

launchctl unload "$launch_agent_path"
launchctl load "$launch_agent_path"
