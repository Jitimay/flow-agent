// MCP Tools API Server
import express from 'express';
import cors from 'cors';
import { spawn } from 'child_process';

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static('.'));

class McpApiServer {
    constructor() {
        this.mcpProcess = null;
        this.requestId = 0;
        this.pendingRequests = new Map();
        this.isReady = false;
    }

    async startMcpServer() {
        return new Promise((resolve) => {
            this.mcpProcess = spawn('python3', ['../ai-bridge/mcp_server.py'], {
                stdio: ['pipe', 'pipe', 'pipe'],
                cwd: process.cwd()
            });

            this.mcpProcess.stdout.on('data', (data) => {
                const lines = data.toString().split('\n').filter(line => line.trim());
                
                for (const line of lines) {
                    try {
                        const response = JSON.parse(line);
                        this.handleMcpResponse(response);
                    } catch (e) {
                        console.log('MCP Output:', line);
                        if (line.includes('Starting FlowAgent Real MCP Server')) {
                            this.isReady = true;
                            resolve();
                        }
                    }
                }
            });

            this.mcpProcess.stderr.on('data', (data) => {
                console.log('MCP Error:', data.toString());
            });

            // Fallback timeout
            setTimeout(() => {
                this.isReady = true;
                resolve();
            }, 2000);
        });
    }

    async callMcpTool(name, args) {
        if (!this.isReady) {
            throw new Error('MCP server not ready');
        }

        const request = {
            jsonrpc: '2.0',
            id: ++this.requestId,
            method: 'tools/call',
            params: { name, arguments: args }
        };

        return new Promise((resolve, reject) => {
            try {
                this.mcpProcess.stdin.write(JSON.stringify(request) + '\n');
                
                const timeout = setTimeout(() => {
                    this.pendingRequests.delete(request.id);
                    reject(new Error('MCP tool call timeout'));
                }, 10000);

                this.pendingRequests.set(request.id, { resolve, reject, timeout });
            } catch (error) {
                reject(error);
            }
        });
    }

    handleMcpResponse(response) {
        if (this.pendingRequests.has(response.id)) {
            const { resolve, reject, timeout } = this.pendingRequests.get(response.id);
            clearTimeout(timeout);
            this.pendingRequests.delete(response.id);
            
            if (response.error) {
                reject(new Error(response.error.message));
            } else {
                try {
                    const result = JSON.parse(response.result[0].text);
                    resolve(result);
                } catch (e) {
                    resolve(response.result);
                }
            }
        }
    }
}

const mcpApi = new McpApiServer();

// API endpoint for MCP tool calls
app.post('/mcp-call', async (req, res) => {
    try {
        const { tool, params } = req.body;
        console.log(`🔧 MCP API Call: ${tool}`, params);
        
        const result = await mcpApi.callMcpTool(tool, params);
        res.json(result);
        
    } catch (error) {
        console.error('MCP API Error:', error.message);
        res.status(500).json({ error: error.message });
    }
});

// Health check endpoint
app.get('/health', (req, res) => {
    res.json({ status: 'ok', mcpReady: mcpApi.isReady });
});

// Start server
const PORT = 8004;
app.listen(PORT, async () => {
    console.log(`🌐 MCP Tools Interface: http://localhost:${PORT}/mcp_interface.html`);
    try {
        await mcpApi.startMcpServer();
        console.log('🔗 MCP Server ready for API calls');
    } catch (error) {
        console.error('Failed to start MCP server:', error);
    }
});
