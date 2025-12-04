#!/bin/bash

# FlowAgent AI Water Management System
# NullShot Hackathon Submission

echo "🤖 Starting FlowAgent AI System"
echo "==============================="

# Kill any existing processes
echo "🧹 Cleaning up existing processes..."
pkill -f "flowagent_ai.py" 2>/dev/null
pkill -f "mcp_server.py" 2>/dev/null
pkill -f "mcp_api.js" 2>/dev/null
pkill -f "python3 -m http.server" 2>/dev/null
sleep 2

# Start MCP Server
echo "🔗 Starting MCP Server..."
cd src/ai-bridge
source ../../venv/bin/activate && python3 mcp_server.py &
MCP_PID=$!
cd ../..

# Start MCP API Server
echo "🔧 Starting MCP API Server..."
cd src/web
node mcp_api.js &
MCP_API_PID=$!
cd ../..

# Start AI Bridge in background
echo "🤖 Starting AI Bridge..."
cd src/ai-bridge
source ../../venv/bin/activate && python3 flowagent_ai.py &
AI_PID=$!
cd ../..

# Start MCP Tools Interface
echo "🔧 Starting MCP Tools Interface..."
cd src/web
node mcp_api.js &
MCP_API_PID=$!
cd ../..

# Wait for services to start
sleep 3

# Start Web Server in background
echo "🌐 Starting Web Interface..."
cd src/web
python3 -m http.server 8003 &
WEB_PID=$!
cd ../..

# Wait for services to initialize
sleep 2

echo ""
echo "🎉 FlowAgent System Started!"
echo "=========================="
echo "🤖 AI Agent:       http://localhost:5002"
echo "🔗 MCP Server:     http://localhost:5003"
echo "🔧 MCP Interface:  http://localhost:8004/mcp_interface.html"
echo "🌐 Web Interface:  http://localhost:8003"
echo "📊 Dashboard:      http://localhost:8003/flowagent_modern_ui.html"
echo ""
echo "🏆 NullShot Hackathon - AI Agent for Water Access"
echo ""
echo "Press Ctrl+C to stop all services..."

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Stopping FlowAgent services..."
    kill $MCP_PID 2>/dev/null
    kill $AI_PID 2>/dev/null
    kill $MCP_API_PID 2>/dev/null
    kill $WEB_PID 2>/dev/null
    pkill -f "flowagent_ai.py" 2>/dev/null
    pkill -f "mcp_server.py" 2>/dev/null
    pkill -f "mcp_api.js" 2>/dev/null
    pkill -f "python3 -m http.server" 2>/dev/null
    echo "✅ All services stopped"
    exit 0
}

# Set trap to cleanup on Ctrl+C
trap cleanup SIGINT SIGTERM

# Keep script running
while true; do
    sleep 1
done
