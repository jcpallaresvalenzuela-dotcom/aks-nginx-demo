from fastapi import FastAPI, Request
from datetime import datetime
import socket

app = FastAPI()

@app.get("/info")
async def get_info(request: Request):
    return {
        "mensaje": "app Python integrada con Nginx 🚀",
        "fecha_hora": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "ip_cliente": request.client.host,
        "hostname_servidor": socket.gethostname(),
        "version_app": "1.0.0"
    }
