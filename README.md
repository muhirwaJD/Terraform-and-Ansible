# 🚀 AutoJenkins: CI/CD Deployment on AWS using Terraform & Ansible

A full DevOps automation project that provisions an EC2 instance on AWS using **Terraform**, and configures it with **Ansible** to install and run **Jenkins** — a powerful CI/CD automation server. No manual steps. No SSHing into servers. Just code.

---

## 🧭 Project Overview

| Section | Summary |
|--------|---------|
| 🌐 **Stack** | Terraform, Ansible, AWS EC2, Ubuntu, Jenkins |
| 🧱 **Purpose** | Automate infrastructure provisioning and CI/CD configuration |
| 🧠 **Skills Demonstrated** | Infrastructure as Code, Configuration Management, Remote Provisioning, EC2 Key Pairs, Ansible Roles, Systemd Debugging |

---

## 🧰 Tech Stack

- ☁️ **AWS EC2** – Cloud infrastructure
- 📦 **Terraform** – Infrastructure provisioning (EC2, SSH keys, Security Groups)
- 🔧 **Ansible** – Server configuration and Jenkins setup
- 🐧 **Ubuntu 22.04** – Operating system for Jenkins server
- ⚙️ **Jenkins** – CI/CD automation tool

---

## 🚀 Features

- ✅ Provisions an EC2 instance with SSH key and security group
- ✅ Installs OpenJDK 17 (required for Jenkins 2.426+)
- ✅ Configures Jenkins repo and installs the latest version
- ✅ Starts Jenkins as a systemd service
- ✅ Uses Ansible with dynamic inventory (IP from Terraform output)
- ✅ No need to SSH into instance — everything is done via code

---

## 📂 Project Structure

```

AutoJenkins/
├── terraform/
│   └── main.tf             # Terraform EC2 + SSH + Security Group setup
├── ansible/
│   ├── playbook.yaml       # Jenkins installation playbook
│   ├── inventory           # Populated dynamically with EC2 IP
│   └── roles/              # (Optional future: Ansible roles)
└── README.md

````

---

## 🛠️ How to Use

### 1. ✅ Requirements

- AWS account + access keys configured (via `aws configure`)
- SSH keypair exists at `~/.ssh/id_ed25519.pub`
- Terraform ≥ v1.2
- Ansible ≥ 2.18

### 2. 🏗️ Provision Infrastructure

```bash
cd terraform/
terraform init
terraform apply -auto-approve
````

This creates:

* EC2 Ubuntu instance
* SSH Key
* Security Group for ports 22 and 8080
* A file at `../ansible/ec2_ip.txt` containing the public IP

### 3. 🔧 Configure Jenkins via Ansible

```bash
cd ../ansible/
echo "[jenkins]" > inventory
cat ec2_ip.txt >> inventory

ansible-playbook -i inventory playbook.yaml
```

---

## 🌐 Access Jenkins

Once deployed, visit:

```
http://<your-ec2-public-ip>:8080
```

To get the admin password:

```bash
ssh -i ~/.ssh/id_ed25519 ubuntu@<your-ip>
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

---

## 🧠 Troubleshooting

* Jenkins won’t start on Java < 17 (you’ll see `exit-code` errors)
* Check logs using:

  ```bash
  sudo journalctl -xeu jenkins
  ```

---

## 📌 Future Improvements

* Add HTTPS and DNS (Route 53 + Let's Encrypt)
* Use S3 for Jenkins config backup
* Add GitHub webhook and deploy jobs

---

## 📬 Contributing

PRs welcome! Fork this repo, improve it, and open a pull request.
Feel free to open issues or feature requests.

---

## 🙋‍♂️ Author

**Muhirwa**
DevOps | AWS | Automation

---
>>>>>>> 1a433a0b0caaab20f4f5615805c47f3c163bbfb9
