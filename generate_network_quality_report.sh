#!/bin/bash

# Sleep for a specified duration to allow network stabilization
sleep_duration=60 # 60 seconds; you can adjust this duration as needed
# If on the same network a log can be generated if this amount of seconds has ellapsed
same_ssid_refresh_time=1800

# Define the output file and prev SSID and time file
logs_directory="/Users/bb/Library/Logs/networkQualityMonitor/"
output_file_path="$logs_directory/networkQuality.log"
prev_ssid_file_path="$logs_directory/prev_ssid.txt"
prev_time_file_path="$logs_directory/prev_time.txt"

# Function to get the current Wi-Fi SSID
get_current_ssid() {
  # networksetup -getairportnetwork en0 | cut -d " " -f2
  networksetup -getairportnetwork en0 | cut -d ":" -f2
}

# Function to read the last recorded value from a file
read_last_recorded_value() {
  local file=$1
  [[ -f $file ]] && cat "$file" || echo ""
}

# Function to log the network quality
log_network_quality() {
  local current_ssid=$1
  local log_entry

  # Run networkQuality and format the output
  # Get all output after SUMMARY substring to ignore update output during tests, then remove SUMMARY w/ tail command
  local network_quality_output=$(networkQuality -s | grep -A 9999 "==== SUMMARY ====" | tail -n +2)

  # Format the log entry
  log_entry="Date: $(date)\n"
  log_entry+="Connected to Wi-Fi SSID: $current_ssid\n"
  log_entry+="$network_quality_output\n"

  # TODO: If there are errors don't save to log
  # Write to the log file
  echo -e "$log_entry" >>"$output_file_path"
}

main() {
  # Load SSID and time from the previous successful run
  prev_ssid=$(read_last_recorded_value "$prev_ssid_file_path")
  prev_time=$(read_last_recorded_value "$prev_time_file_path")
  prev_time=${prev_time:-0} # Default to 0 if not set

  # Allow for network stabilization
  sleep $sleep_duration

  # Get the current SSID and time
  current_ssid=$(get_current_ssid)
  current_time=$(date +%s)
  time_difference=$((current_time - prev_time))

  # TODO: If no network is connected don't run a network test
  # Check if the SSID changed or if it's been more than 30 minutes
  if [ "$current_ssid" != "$prev_ssid" ] || [ $time_difference -gt $same_ssid_refresh_time]; then
    # TODO: Add a delay to let the network connection stabilize
    log_network_quality "$current_ssid"
    # Update previous values
    echo "$current_ssid" >"$prev_ssid_file_path"
    echo "$current_time" >"$prev_time_file_path"
  fi

}

##### Example output #######
# Date: Thu Jan  4 16:16:36 EST 2024
# Connected to Wi-Fi SSID:  JeffLibrary
# Uplink capacity: 128.454 Mbps
# Downlink capacity: 25.979 Mbps
# Uplink Responsiveness: High (29.747 milliseconds | 2017 RPM)
# Downlink Responsiveness: Medium (198.675 milliseconds | 302 RPM)
# Idle Latency: 28.833 milliseconds | 2142 RPM

main
