export default {
  agent: {
    name: 'FlowAgent',
    description: 'AI agent for decentralized water distribution',
    entry: './src/ai-bridge/nullshot_agent.js',
    framework: '@nullshot/typescript-agent-framework'
  },
  
  mcp: {
    servers: [
      {
        name: 'water-management',
        command: 'python3',
        args: ['src/ai-bridge/mcp_server.py'],
        transport: 'stdio'
      }
    ]
  },
  
  capabilities: [
    'blockchain-monitoring',
    'iot-control',
    'sms-generation'
  ]
};
