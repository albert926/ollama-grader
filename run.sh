#!/bin/bash

echo "Starting ProblemChecker System..."
echo "---------------------------------"

# STEP 1: Start Ollama model in background
echo "[1/3] Loading Ollama model: alberttalkstech/problemChecker"
ollama serve > /dev/null 2>&1 &       # ensures Ollama server is running
sleep 2
ollama run alberttalkstech/problemChecker "init" > /dev/null 2>&1 &
echo "Ollama model is running."

# STEP 2: Activate Python venv and start proxy
echo "[2/3] Starting Python CORS Proxy on port 8080..."
source venv/bin/activate
python3 proxy.py > proxy.log 2>&1 &
PROXY_PID=$!

sleep 2
echo "Proxy running (PID: $PROXY_PID)"

# STEP 3: Serve HTML
echo "[3/3] Starting local web server on port 8000..."
python3 -m http.server 8000 > http.log 2>&1 &
SERVER_PID=$!

sleep 2
echo "Web server running (PID: $SERVER_PID)"

# Open browser automatically
open http://localhost:8000

echo "---------------------------------"
echo "System ready!"
echo "Visit: http://localhost:8000"
echo "Press CTRL+C to stop everything."
echo

# Trap CTRL+C and shut down cleanly
trap "echo; echo Stopping services...; kill $PROXY_PID $SERVER_PID; deactivate; exit 0" SIGINT

# Keep script alive
while true; do sleep 1; done

