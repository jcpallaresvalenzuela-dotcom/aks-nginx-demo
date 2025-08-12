# 🚀 AKS DevOps Demo – Ansible + GitHub Actions CI/CD

Despliegue de una aplicación Nginx en un **cluster AKS**, usando **Ansible** y **GitHub Actions**.

---

## 🛠 Tecnologías utilizadas
- **Azure Kubernetes Service (AKS)**
- **Azure Container Registry (ACR)**
- **Docker**
- **Ansible**
- **GitHub Actions**

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
        └── index.html
```
## 🚀 Cómo usarlo

1️⃣ Requisitos previos
Tener un AKS y un ACR configurados.

Configurar el acceso desde GitHub Actions:

Crear un Service Principal en Azure:

`az ad sp create-for-rbac --name "github-aks" --sdk-auth`

2️⃣ Variables de entorno

```sh
ACR_NAME: tuacr.azurecr.io
RESOURCE_GROUP: tu-rg
AKS_NAME: tu-aks
```

3️⃣ Ejecutar pipeline
Hacer commit y push a master en path app o ansible.

GitHub Actions ejecutará:

CI: Build & Push imagen.

CD: Despliegue automático en AKS con Ansible.


Acceso al nginx via
```sh
kubectl get svc nginx-demo-service
```