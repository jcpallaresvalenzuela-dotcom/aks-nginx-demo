#!/bin/bash
set -e

# Crear carpeta para logs
mkdir -p /var/log/nginx

# Archivo HTML básico
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<body>
<p>Desplegado con GitHub Actions + Ansible</p>
</body>
</html>
EOF

# Configuración de básica de nginx 
cat <<EOF > /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name _;
    
    # Sirve archivos estáticos
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }

    # Redirige /info hacia el servicio Python en el puerto 8000
    location /info {
        proxy_pass http://127.0.0.1:8000/info;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
}
EOF
