
# Node.js_app_using_terraform

This repo uses Terraform to deploy the kubectl manifest of a simple Node.js app to the kind cluster installed locally and setup monitoring and observability using kubectl terraform provider. This is to fulfill the task for a devops intern role [intern-task](https://github.com/ignitedotdev/intern-task).

## Prerequisites

* [Docker](#Docker) to run an instance of HashiCups locally.
[Kubectl](#Kubectl) to perform basic Kubernetes functions on our cluster
[Terraform CLI](#Terraform).

- ### Install Docker<a name="Docker"></a>
Run the below command to install Docker
```bash
sudo apt update -y && sudo apt install docker.io -y && sudo systemctl enable --now docker
```
Verify Docker Installation
```bash
docker --version
```
- ### [Install Kubectl](#Kubectl)
```
sudo apt update && sudo snap install kubectl --classic
```
Verify Kubectl Installation
```
kubectl version --output=yaml
```
- ### [Install Terraform](#Terraform)
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
## Lets Begin

- Clone this repo:
```
git clone https://github.com/emmanuelogar/Node.js_app_using_terraform.git && cd Node.js_app_using_terraform\ 
```
run ```./install_kind.sh ``` to install kind and create a local kind cluster with the specified name, provides cluster information, downloads the kubeconfig for the cluster and store in a file.

- Deploy the kubernetes manifest using the kubectl terraform provider to the running kind cluster.
```
terraform init
terraform plan -out=tfplan
terraform apply "tfplan"
```
