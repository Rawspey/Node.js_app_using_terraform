

# Node.js_app_using_terraform

This repo uses Terraform to deploy the kubectl manifest of a simple Node.js app to the kind cluster installed locally and setup monitoring and observability using kubectl terraform provider. This is to fulfill the task for a devops intern role [intern-task](https://github.com/ignitedotdev/intern-task).

## Prerequisites

* [Docker](#Docker) to run an instance of HashiCups locally.
- [Kubectl](#Kubectl) to perform basic Kubernetes functions on our cluster
- [Terraform CLI](#Terraform).
- [Helm](#Helm)

### Install Docker<a name="Docker"></a>
Run the below command to install Docker
```bash
sudo apt update -y && sudo apt install docker.io -y && sudo systemctl enable --now docker
```
Verify Docker Installation
```bash
docker --version
```
### Install Kubectl<a name="Kubectl"></a>
```
sudo apt update && sudo snap install kubectl --classic
```
Verify Kubectl Installation
```
kubectl version --output=yaml
```
### Install Terraform<a name="Terraform"></a>
Install Terraform from APT repository
```bash
sudo apt install software-properties-common gnupg2 curl -y
```
```bash
curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
```
```bash
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```
Now install terraform on your Ubuntu Linux system:
```bash
sudo apt install terraform
```
Verify Terraform Installation
```
$ terraform --version
Terraform v1.5.7
on linux_amd64
```
### Install Helm<a name="Helm"></a>
```
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```
## Lets Begin
- Clone this repo:
```
git clone https://github.com/emmanuelogar/Node.js_app_using_terraform.git && cd Node.js_app_using_terraform\ 
```
run ```./install_kind.sh ``` to install kind and create a local kind cluster with the specified name, provides cluster information, downloads the kubeconfig for the cluster and store in a file.

- Deploy the kubernetes manifest to the running kind cluster using the kubectl terraform provider.
- setup monitoring and observability for the prometheus cluster using the kube-prometheus stack with terraform helm provider.

```
terraform init
terraform plan -out=tfplan
terraform apply "tfplan"
```

- ### Connecting to Prometheus:
Port Forward to Prometheus
```
kubectl port-forward -n monitoring svc/kube-prometheus-kube-prome-prometheus 9090
```
This command forwards local port 9090 to the Prometheus service's port within the monitoring namespace.
Access Prometheus Web UI:
Open your web browser and navigate to ```http://localhost:9090```. You should see the Prometheus web user interface, where you can query metrics and create custom dashboards.
- ### Connecting to Grafana:
Port Forward to Grafana:
```
kubectl port-forward -n monitoring svc/kube-prometheus-grafana 3000:80
```
This command forwards local port 3000 to the Grafana service's port within the monitoring namespace.

Access Grafana Web UI:
Open your web browser and go to ``` http://localhost:3000```. Grafana's default login credentials are typically:

Username: admin
Password: You might need to obtain the password from your Grafana configuration or secret.

To retrieve the Grafana admin password from the secret
```
kubectl get secrets -n monitoring
kubectl describe secret kube-prometheus-grafana -n monitoring
kubectl get secret kube-prometheus-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
```
After logging in, you can set up dashboards and visualize your Kubernetes cluster's metrics.
