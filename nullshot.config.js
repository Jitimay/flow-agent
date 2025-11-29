export default {
  name: 'FlowAgent',
  description: 'Decentralized AI water distribution for rural Africa',
  category: 'Track 1a - MCPs/Agents using NullShot Framework',
  tags: ['Nullshot Hacks S0', 'water-access', 'rural-infrastructure', 'blockchain-iot'],
  
  agent: {
    framework: '@nullshot/typescript-agent-framework',
    entry: './src/ai-bridge/nullshot_agent.js',
    capabilities: [
      'blockchain-event-monitoring',
      'iot-device-control', 
      'sms-command-generation',
      'mcp-tool-integration'
    ]
  },

  mcp: {
    server: './src/ai-bridge/mcp_server.py',
    tools: [
      'verify_water_payment',
      'create_water_asset',
      'generate_pump_command'
    ]
  },

  demo: {
    video: 'https://youtu.be/your-demo-video',
    live: 'http://localhost:8002/flowagent_modern_ui.html'
  },

  impact: {
    problem: 'Rural Africa lacks clean water access infrastructure',
    solution: 'AI agents automate crypto-to-water conversion on 2G networks',
    beneficiaries: 'Rural communities, NGOs, disaster relief organizations'
  }
};
