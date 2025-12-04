#!/bin/bash

echo "🤖 Starting FlowAgent AI System (Virtual Environment)"
echo "===================================================="

# Kill any existing processes
echo "🧹 Cleaning up existing processes..."
pkill -f "mcp_server.py" 2>/dev/null
pkill -f "flowagent_ai.py" 2>/dev/null
pkill -f "http.server" 2>/dev/null
sleep 2

# Activate virtual environment
echo "🐍 Activating virtual environment..."
source venv/bin/activate

# Start MCP Server
echo "🔗 Starting MCP Server..."
cd src/ai-bridge
python3 mcp_server.py &
MCP_PID=$!
cd ../..

# Start AI Bridge
echo "🤖 Starting AI Bridge..."
cd src/ai-bridge
python3 flowagent_ai.py &
AI_PID=$!
cd ../..

# Wait for services to start
sleep 3

# Start Web Interface
echo "🌐 Starting Web Interface..."
cd src/web
python3 -m http.server 8004 &
WEB_PID=$!
cd ../..

echo ""
echo "🎉 FlowAgent System Started!"
echo "=========================="
echo "🤖 AI Agent:       http://localhost:5002"
echo "🔗 MCP Server:     http://localhost:5003"
echo "🌐 Web Interface:  http://localhost:8004"
echo "📊 Dashboard:      http://localhost:8004/flowagent_modern_ui.html"
echo ""
echo "🏆 NullShot Hackathon - AI Agent for Water Access"
echo ""
echo "Press Ctrl+C to stop all services..."

# Wait for interrupt
trap 'echo ""; echo "🛑 Stopping FlowAgent..."; kill $MCP_PID $AI_PID $WEB_PID 2>/dev/null; exit' INT
wait
