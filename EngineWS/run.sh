#!/bin/bash
cd "$(dirname "$0")"

# Set default engine path
export DEFAULT_ENGINE_PATH="/opt/homebrew/bin/stockfish"

# Upgrade pip to the latest version
python -m pip install --upgrade pip

echo "Uninstalling existing version of my_main_manager..."
python -m pip uninstall -y my_main_manager

echo "Installing dependencies from requirements.txt..."
if ! python -m pip install -r requirements.txt; then
    echo "Failed to install dependencies. Exiting."
    exit 1
fi

echo "Starting application..."
if ! python -m uvicorn main:app --reload; then
    echo "Failed to start the application. Exiting."
    exit 1
fi
