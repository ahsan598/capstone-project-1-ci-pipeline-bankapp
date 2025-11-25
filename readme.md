# 🚀 Capstone DevOps Project – End-to-End CI/CD on AWS EKS

This Capstone project demonstrates a complete **Cloud + DevOps + Kubernetes** ecosystem including:
- Terraform for Infrastructure Provisioning
- AWS EKS as the Kubernetes platform
- Jenkins CI for build, test, scan, and Docker image creation
- Jenkins CD for deploying to EKS
- Kubernetes (Ingress, HPA, Secrets, PVC, Storage)
- Cert-Manager + Let’s Encrypt for TLS Automation
- DevSecOps with Trivy & SonarQube
- Artifact Management using Nexus
- GitOps-style Manifest Updates for CD

This project mimics a real-world production DevOps pipeline from **Infrastructure → CI → CD → Deployment → Security**.


### 📁 Repository Structure (3 Major Repos)

1. [Infrastructure Repo](https://github.com/ahsan598/capstone-project-1-terraform-aws-eks): AWS EKS Provisioning

2. [CI Pipeline Repo](#): Application Build (This Repo)

3. [CD Pipeline Repo](https://github.com/ahsan598/capstone-project-1-cd-k8s-deployment): AWS EKS Deployment


### Architecture Diagram
![Architecture](/capstone-project1-ci-pipeline/assets/imgs/capstone_final.jpg)


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



### 📢 Final Workflow Summary
1. Terraform provisions EKS
2. Jenkins CI builds/test/scans and publishes Docker image
3. CI updates CD repo
4. Jenkins CD auto-deploys changes to EKS
5. Kubernetes runs services behind ingress + TLS
6. HPA scales the application
7. All services run securely with RBAC, TLS, storage, and monitoring


### 🎯 Project Goals Achieved
- Build a production-style AWS infrastructure
- Implement complete CI + CD automation
- Enable DevSecOps (Sonar + Trivy)
- Use GitOps-style manifest updates
- Deploy full microservice architecture on EKS
- Secure with RBAC, Ingress TLS, HPA, Storage


### 🏁 Conclusion
This capstone project covers **end-to-end DevOps:**
- Infrastructure as Code (Terraform)
- Continuous Integration (Jenkins)
- Continuous Deployment (Jenkins + K8s)
- Cloud Infrastructure (AWS EKS)
- Secure deployments (Trivy, RBAC, Cert-Manager)
- GitOps-style manifest tracking

**Perfect for:**
- Learning DevOps
- Interview preparation
- Portfolio projects
- Real-world implementation practice


---

## 📖 Read the Full Blog
https://amitsinghh.medium.com/capstone-devsecops-cloud-devops-project-1a8af0c0a6c3
