#!/bin/bash

echo "🔧 FlowAgent MCP Tools Demo"
echo "=========================="

# Start MCP API server
cd src/web
node mcp_api.js &
API_PID=$!
cd ../..

sleep 3

echo "🚰 Testing Water Pump Activation..."
curl -s -X POST http://localhost:8004/mcp-call \
  -H "Content-Type: application/json" \
  -d '{"tool":"activate_water_pump","params":{"pump_id":"PUMP001","duration":10,"tx_hash":"0xdemo123"}}' | jq .

echo ""
echo "📱 Testing SMS Status Check..."
curl -s -X POST http://localhost:8004/mcp-call \
  -H "Content-Type: application/json" \
  -d '{"tool":"check_sms_status","params":{"esp32_ip":"192.168.1.100"}}' | jq .

echo ""
echo "🌐 MCP Interface available at: http://localhost:8004/mcp_interface.html"
echo "Press Ctrl+C to stop..."

# Cleanup on exit
trap "kill $API_PID 2>/dev/null; exit 0" SIGINT SIGTERM

# Keep running
while true; do sleep 1; done
