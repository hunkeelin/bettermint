#!/bin/bash
cd "$(dirname "$0")"

# macOS specific setup for GUI applications
export DISPLAY=:0

# Check if we're in a GUI environment
if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    echo "Warning: No display environment detected. GUI dialogs may not work."
fi

# Upgrade pip to the latest version
python3 -m pip install --upgrade pip

echo "Uninstalling existing version of my_main_manager..."
python3 -m pip uninstall -y my_main_manager

echo "Installing dependencies from requirements.txt..."
if ! python3 -m pip install -r requirements.txt; then
    echo "Failed to install dependencies. Exiting."
    exit 1
fi

echo "Starting application..."
if ! python3 -m uvicorn main:app --reload --host 0.0.0.0 --port 8000; then
    echo "Failed to start the application. Exiting."
    exit 1
fi
