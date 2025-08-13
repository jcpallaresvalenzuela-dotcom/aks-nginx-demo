FROM python:3.10-slim

# Instalar Nginx y dependencias
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copiar HTML
COPY index.html /usr/share/nginx/html/index.html

# Copiar script de configuración de Nginx
COPY setup_nginx.sh /setup_nginx.sh
RUN chmod +x /setup_nginx.sh && /setup_nginx.sh

# Copiar app Python
WORKDIR /app
COPY app.py requirements.txt /app/

# Instalar dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# Comando para levantar Nginx + API Python
CMD service nginx start && uvicorn app:app --host 0.0.0.0 --port 8000
