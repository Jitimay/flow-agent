# FlowAgent Installation Guide

## Prerequisites
- Node.js 18+
- Python 3.8+
- ESP32 with SIM800L
- MetaMask wallet

## Quick Setup
```bash
git clone https://github.com/yourusername/flowagent
cd FlowAgent
./start.sh
```

## Hardware Setup
1. Flash `src/esp32/flowagent_working_sms_ui.ino` to ESP32
2. Connect SIM800L module
3. Connect water pump to GPIO 2

## Access
- Web Interface: http://localhost:8002/flowagent_modern_ui.html
- AI Bridge: http://localhost:5002/status
- MCP Server: http://localhost:5003
