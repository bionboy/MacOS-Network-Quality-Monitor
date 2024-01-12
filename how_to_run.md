
## Copy plist to ~/Library/LaunchAgents/
```sh
cp com.user.networkQualityReport.plist ~/Library/LaunchAgents/
```

## Unload and load commands
```sh
launchctl unload ~/Library/LaunchAgents/com.user.networkQualityReport.plist
launchctl load ~/Library/LaunchAgents/com.user.networkQualityReport.plist
```
