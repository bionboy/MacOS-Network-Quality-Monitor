# MacOS-Network-Quality-Monitor
Automated network quality monitoring script for MacOS


# Install
Run `install.sh` from its directory:
```sh
./install.sh
```
Or manually:

1. Copy plist to ~/Library/LaunchAgents/
```sh
cp com.user.networkQualityReport.plist ~/Library/LaunchAgents/
```

2. Unload and load commands
```sh
launchctl load ~/Library/LaunchAgents/com.user.networkQualityReport.plist
```

# View Logs

```sh
cat ~/Library/Logs/networkQualityMonitor/networkQuality.log
```

# Develop

1. Install like above
2. To refresh after saving edits, use the script `reload.sh`
or run the unload and load commands
```sh
launchctl unload ~/Library/LaunchAgents/com.user.networkQualityReport.plist
launchctl load ~/Library/LaunchAgents/com.user.networkQualityReport.plist
```


# TODO: add instructions for using a symlink to keep the plist file from the repo in sync with the system's