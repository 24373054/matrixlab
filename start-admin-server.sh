#!/bin/bash

# Matrix Lab Admin Server Startup Script - Production Ready

echo "Starting Matrix Lab Admin Server..."

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3 first."
    exit 1
fi

# Check if required Python packages are installed
echo "Checking Python dependencies..."
python3 -c "import flask, yaml" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Installing required Python packages..."
    pip3 install flask pyyaml
fi

# Start the admin server
echo "Admin server starting on http://localhost:3001 (also accessible via IP)"
echo "Admin panel: http://localhost:3001/admin.html (or /admin.html via IP)"
echo "Health check: http://localhost:3001/api/health (or /api/health via IP)"
echo ""
echo "Default credentials:"
echo "Username: admin"
echo "Password: matrixlab2025"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

python3 admin-server.py
