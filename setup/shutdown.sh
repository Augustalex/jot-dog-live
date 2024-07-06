#!/bin/bash

# Function to find and kill processes running on a given port
kill_process_on_port() {
  local port=$1
  # Find the process ID (PID) running on the specified port
  pid=$(lsof -t -i:$port)
  if [ -n "$pid" ]; then
    echo "Killing process $pid running on port $port"
    kill -9 $pid
  else
    echo "No process found running on port $port"
  fi
}

# Kill processes running on ports 1234 and 3124
kill_process_on_port 1234
kill_process_on_port 3124

echo "Done."