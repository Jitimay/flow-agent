#!/usr/bin/env python3
"""
FlowAgent MCP Server - Simplified Version
No external dependencies required
"""

import json
import time
from http.server import HTTPServer, BaseHTTPRequestHandler
import threading

class MCPHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/status':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            
            status = {
                "status": "online",
                "service": "FlowAgent MCP Server",
                "timestamp": int(time.time()),
                "framework": "NullShot"
            }
            
            self.wfile.write(json.dumps(status).encode())
        else:
            self.send_response(404)
            self.end_headers()
    
    def do_POST(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length)
        
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        
        response = {
            "status": "received",
            "message": "MCP command processed",
            "timestamp": int(time.time())
        }
        
        self.wfile.write(json.dumps(response).encode())
    
    def log_message(self, format, *args):
        print(f"🔗 MCP Server: {format % args}")

def start_mcp_server():
    server = HTTPServer(('localhost', 5003), MCPHandler)
    print("🔗 MCP Server started on http://localhost:5003")
    server.serve_forever()

if __name__ == "__main__":
    start_mcp_server()
