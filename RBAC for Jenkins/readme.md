# 🔐 Role-Based Access Control (RBAC) for Jenkins on Kubernetes
 
This RBAC configuration allows the **Jenkins ServiceAccount** to deploy applications, manage resources inside the `webapps` namespace, and perform limited cluster-wide operations such as working with **StorageClasses, PersistentVolumes, and ClusterIssuers** (for cert-manager).


### ⚙️ Components & Permissions Breakdown

1. **ServiceAccount:** 
A dedicated ServiceAccount named `jenkins` is created inside the `webapps` namespace.
   - Used by Jenkins to authenticate to the Kubernetes API.
   - The token associated with this SA will be used in Jenkins credentials.

1. **Role (Namespace-Level Permissions):**
This Role grants Jenkins permissions within the `webapps` namespace only, including:

   **a. Core API Resources**
   - pods, services, secrets, configmaps, PVC

   **b. Apps API Resources**
   - deployments, replicasets

   **c. Networking & Autoscaling Resources**
   - ingress, HPA

   This allows Jenkins to successfully apply, update, delete, and restart resources through manifests.


3. **RoleBinding**:
This binds the jenkins Role → jenkins ServiceAccount in the same namespace:
   - Ensures Jenkins can only manage resources inside webapps.
   - Implements “least privilege” for namespace operations.

4. **ClusterRole (Cluster-Wide Permissions)**:
These permissions are required for resources that exist at the cluster level, not within a namespace.
Provides access to:
   - persistentvolumes, storageclasses, clusterissuers

   These are needed for:
     - Dynamic volume provisioning
     - Using AWS EBS StorageClass
     - Managing Let's Encrypt ClusterIssuer (cert-manager)

5. **ClusterRoleBinding**: This connects jenkins ServiceAccount → jenkins-cluster-role. Meaning Jenkins can work with cluster-scoped objects when needed.



### 🛠 How to Apply RBAC YAML Files
1. Save each YAML snippet as a separate file:
   ```cpp
   serviceaccount.yaml
   role.yaml
   rolebinding.yaml
   clusterrole.yaml
   clusterrolebinding.yaml
   ```

2. Apply them in the following order:
   ```sh
   kubectl apply -f serviceaccount.yaml
   kubectl apply -f role.yaml
   kubectl apply -f rolebinding.yaml
   kubectl apply -f clusterrole.yaml
   kubectl apply -f clusterrolebinding.yaml   
   ```

3. Use the following commands to check Jenkins SA permissions:
   ```bash
   kubectl auth can-i create secrets --as=system:serviceaccount:webapps:jenkins -n webapps
   kubectl auth can-i create storageclasses --as=system:serviceaccount:webapps:jenkins
   kubectl auth can-i create persistentvolumes --as=system:serviceaccount:webapps:jenkins
   ```

   If output is "**yes**", the SA is properly configured.


### 🎯 Summary

With this RBAC setup:
- Jenkins can fully deploy workloads into webapps namespace
- Jenkins can manage Deployments, Services, HPA, Ingress, PVC, Secrets
- Jenkins can work with StorageClasses + PVs
- Jenkins can create and manage ClusterIssuers (cert-manager)
- Secure, correctly scoped permissions for a real DevOps CI/CD pipeline