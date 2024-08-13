#!/bin/bash

#Objective: Checks for system resources (can be memory, cpu, disk, all of the above and/or more) and pushes those resources to the GitHub repo.
#IMPORTANT: make sure you use conditional statements and exit codes (0 or 1) if any resource exceeds a certain threshold.
#SEE:  https://www.geeksforgeeks.org/how-to-use-exit-code-to-read-from-terminal-from-script-and-with-logical-operators/ for more information
#Note: Why are exit codes important? Especially if running the script through a CICD Pipeline?

#Define variables
to="ashleigh.kuralabs@gmail.com"
subject="Abnormal CPU usage"


#Define CPU usage, display percentage, and exit code
cpu_usage=$(top -bn1 | grep "CPU" | awk '{print ($2 + $4)}')
    echo "CPU Usage: $cpu_usage%"

if (( $(echo "$cpu_usage > 60" | bc -l) )); then 
    exit_code=1
else
    exit_code=0
fi

exit_code=$?

#If Exit code is not a success "0", then send an email
if [ "$exit_code" -ne "0" ]; then 
    body="CPU usage is exceeding expectations at $cpu_usage%. Attention is necessary!"
    echo "$body" | mail -s "$subject" "$to"
fi

exit $exit_code
