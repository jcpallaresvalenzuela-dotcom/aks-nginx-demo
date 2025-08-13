# 🚀 AKS DevOps Demo – Ansible + GitHub Actions CI/CD

Despliegue de una aplicación Nginx en un **cluster AKS**, usando **Ansible** y **GitHub Actions**, junto con una aplicación **Python** ejecutándose con **Uvicorn**.

---

## 🛠 Tecnologías utilizadas
- **Azure Kubernetes Service (AKS)**
- **Azure Container Registry (ACR)**
- **Docker**
- **Ansible**
- **GitHub Actions**
- **Python + Uvicorn (app backend)**
- **Nginx (reverse proxy y server de archivos estáticos)**

---

## 📦 Flujo CI/CD
1. **Push a main**:
   - Construcción de la imagen Docker.
   - Publicación en Azure Container Registry (ACR).

2. **Despliegue con Ansible**:
   - Ejecución automática de un playbook que aplica `Deployment` y `Service` en AKS.
   - Uso del módulo `kubernetes.core.k8s` para aplicar manifests.

---

## 📂 Estructura del repositorio

```sh
aks-nginx-demo/
└── aks-nginx-demo
    ├── README.md
    ├── ansible
    │   ├── inventory.ini
    │   ├── playbook.yml
    │   └── roles
    │       └── deploy_app
    │           ├── tasks
    │           │   └── main.yml
    │           └── templates
    │               ├── deployment.yml.j2
    │               └── service.yml.j2
    └── app
        ├── Dockerfile
        ├── index.html
        ├── app.py
        ├── requirements.txt
        └── setup_nginx.sh
```
## 🚀 Cómo usarlo

1️. Requisitos previos
* Tener un AKS y un ACR desplegados.

* Configurar GitHub Actions con `aks-nginx-demo\.github\workflows\main.yml`:

* Crear un Service Principal en Azure y guardar el JSON de salida como secreto en GitHub.

   `az ad sp create-for-rbac --name "github-aks" --sdk-auth > secret.json`

   * Crea un **Environment** en Settings -> Actions secrets and variables y nombralo `AZURE_CREDENTIALS`

   * Crea un **Secret** dentro del environment y nombralo tambien `AZURE_CREDENTIALS`


2. Configura tus variables de entorno en `aks-nginx-demo\.github\workflows\main.yml`:

```sh
ACR_NAME: <ACR-NAME>.azurecr.io
RESOURCE_GROUP: <RG-NAME>
AKS_NAME: <AKS-NAME>
```

3. Crea un namespace llamado `project1`. Es donde se desplegará nginx

4. El deployment del nginx tiene añadido un secreto `acr-secret` que debe contener las credenciales de tu ACR, por lo que hay que crearlo previamente en tu AKS

```sh
#Crear secret
kubectl create secret -n project1 docker-registry acr-secret \                                                                                                                                                                      
  --docker-server=<ACR-NAME>.azurecr.io \
  --docker-username=<ACR-USER> \
  --docker-password=<ACR-PASSWORD>
```

5. Ejecutar pipeline haciendo alguna modificacion menor sobre algun file dentro de /app o /ansible o de manera manual sobre Actions

>El workflow de GithubAction está configurado para que se ejecute automaticamente cuando se realiza un commit dentro de algun archivo de las carpetas `app` o `ansible`.


## 🌐 Acceso a la app
Acceso a Nginx vía la IP pública del LoadBalancer:

```sh
kubectl get svc nginx-demo-service
```
>Nginx sirve index.html en /.
>App Python disponible en /info/ vía proxy inverso desde Nginx.