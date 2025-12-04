# FlowAgent: NullShot Framework Water Distribution Agent

**"AI Agent → MCP → Blockchain → Physical Water Pump"**

🏆 **NullShot Hacks Season 0 - Track 1a Submission**

## 🌊 Overview
FlowAgent is a decentralized, AI-assisted water distribution infrastructure using the **NullShot Framework** for rural communities with limited connectivity. It transforms crypto payments into real-world water access via autonomous AI agents.

## 🤖 NullShot Framework Integration
- **Agent Framework**: Built on NullShot TypeScript Agent Framework
- **MCP Tools**: Custom MCP tools for blockchain-IoT coordination (`activate_water_pump`, `check_sms_status`)
- **Autonomous Operation**: AI agent monitors blockchain events and generates SMS commands for water pump activation
- **Real-World Impact**: Physical water pumps activated by blockchain payments via autonomous AI agent

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ with NullShot Framework
- Python 3.8+ for MCP server
- ESP32 LilyGO T-Call SIM800L
- Base L2 wallet (MetaMask)

### 1. Install NullShot Framework
```bash
npm install @nullshot/typescript-agent-framework
```

### 2. Launch FlowAgent System
```bash
cd /home/josh/Kiro/FlowAgent
npm run start
```

### 3. Submit to NullShot Platform
```bash
npm run nullshot
```

## 🔧 Architecture

**Blockchain Layer**: Base L2 processes water credit purchases
**AI Agent Layer**: NullShot Framework agent monitors blockchain events and generates SMS commands  
**MCP Layer**: Model Context Protocol coordinates blockchain-IoT communication
**IoT Layer**: ESP32 receives SMS commands, activates physical pumps

## 🌍 Real-World Impact
- **Rural Water Access**: Serves communities with only 2G connectivity
- **Corruption-Free**: Blockchain transparency eliminates intermediaries
- **NGO Deployment**: Scalable infrastructure for humanitarian organizations
- **Disaster Relief**: Rapid water distribution in emergency situations

## 🏆 NullShot Hacks Season 0
**Track**: 1a - MCPs/Agents using NullShot Framework  
**Prize**: $5,000 category  
**Tags**: #NullshotHacksS0 #WaterAccess #RuralInfrastructure

Built to demonstrate the agentic economy solving real humanitarian problems through AI + blockchain convergence.
