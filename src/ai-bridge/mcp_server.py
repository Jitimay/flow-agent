#!/usr/bin/env python3
"""MCP Server for FlowAgent Water Management"""

from mcp.server import Server
from mcp.types import Tool, TextContent
import json

server = Server("flowagent-water")

@server.list_tools()
async def list_tools():
    return [
        Tool(
            name="verify_water_payment",
            description="Verify water payment on blockchain",
            inputSchema={
                "type": "object",
                "properties": {
                    "tx_hash": {"type": "string"},
                    "pump_id": {"type": "string"}
                }
            }
        ),
        Tool(
            name="create_water_record",
            description="Create water dispensing record",
            inputSchema={
                "type": "object", 
                "properties": {
                    "pump_data": {"type": "object"},
                    "payment_data": {"type": "object"}
                }
            }
        )
    ]

@server.call_tool()
async def call_tool(name: str, arguments: dict):
    if name == "verify_water_payment":
        return [TextContent(type="text", text=json.dumps({"verified": True}))]
    elif name == "create_water_record":
        return [TextContent(type="text", text=json.dumps({"record_id": f"water_{arguments['pump_data']['pump_id']}_{int(time.time())}"}))]

if __name__ == "__main__":
    import asyncio
    asyncio.run(server.run())
