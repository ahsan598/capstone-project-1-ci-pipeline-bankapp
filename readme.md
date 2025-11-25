# 🚀 Capstone DevSecOps with Jenkins CI/CD, Kubernetes and Monitoring

This Capstone project demonstrates a complete **Cloud + DevOps + Kubernetess + Monitoring** ecosystem including:
- Terraform for Infrastructure Provisioning
- AWS EKS as the Kubernetes platform
- Jenkins CI for build, test, scan, and Docker image creation
- Jenkins CD for deploying to EKS
- Kubernetes (Ingress, HPA, Secrets, PVC, Storage)
- Cert-Manager + Let’s Encrypt for TLS Automation
- DevSecOps with Trivy & SonarQube
- Artifact Management using Nexus
- GitOps-style Manifest Updates for CD
- Prometheus & Grafana Monitoring Stack


### 📁 Repository Structure (4 Major Repos)

1. [Infrastructure Repo](https://github.com/ahsan598/capstone-project-1-terraform-aws-eks): AWS EKS Provisioning

2. [CI Pipeline Repo](#): Application Build (This Repo)

3. [CD Pipeline Repo](https://github.com/ahsan598/capstone-project-1-cd-k8s-deployment): AWS EKS Deployment

4. [Monitoring Repo](https://github.com/ahsan598/capstone-project-1-monitoring-stack): Prometheus + Grafana Monitoring Stack



### Architecture Diagram
![Architecture](/assets/imgs/capstone_final.jpg)


### 🛠 Tools Used
| Category               | Tools / Services                                              |
| ---------------------- | ------------------------------------------------------------- |
| **Cloud & Infra**      | AWS EKS, VPC, IAM, EBS, Terraform                             |
| **CI/CD**              | Jenkins, Maven, Docker, GitHub, Nexus                         |
| **Code Quality**       | SonarQube                                                     |
| **Security**           | Trivy (FS + Image Scan)                                       |
| **Kubernetes**         | Deployments, Services, Ingress, HPA, PVC, ConfigMaps, Secrets |
| **TLS & Certificates** | Cert-Manager, Let’s Encrypt                                   |
| **GitOps**             | Automated Manifest Updates in CD Repo                         |
| **Monitoring**         | Prometheus, Grafana, Node Exporter, Kube State Metrics        |



### 📢 Final Workflow Summary
1. Terraform provisions EKS
2. Jenkins CI builds/test/scans and publishes Docker image
3. CI pipeline updates CD repo with new image tag
4. Jenkins CD deploys updated manifests to EKS
5. Ingress + SSL via Cert-Manager exposes application securely
6. HPA auto-scales the application
7. Monitoring stack tracks cluster + application health


### 🎯 Project Goals Achieved
- Infrastructure as Code with Terraform
- Complete CI/CD automation using Jenkins
- DevSecOps integration (SonarQube + Trivy)
- GitOps-style manifest updates
- EKS deployment with HPA, Ingress, TLS
- Production‑grade monitoring with Prometheus & Grafana


### 🏁 Conclusion
This capstone project delivers a full end-to-end DevSecOps pipeline, including:
- Cloud Infrastructure (Terraform + AWS EKS)
- Continuous Integration (Jenkins)
- Continuous Deployment (Jenkins + Kubernetes)
- Security Scanning (Trivy, SonarQube)
- GitOps Workflow
- Full Monitoring & Observability

**🎓 Perfect for:**
- DevOps Learning
- Portfolio Projects
- Certifications
- Interview Preparation


---

## 📖 Read the Full Blog
https://amitsinghh.medium.com/capstone-devsecops-cloud-devops-project-1a8af0c0a6c3
