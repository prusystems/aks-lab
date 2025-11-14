# 🧭 AKS Terraform Runbook

This runbook documents the full setup → validation → teardown cycle for the AKS lab.

---

## 1️⃣ Setup

### System Prep
```bash
brew update
brew install terraform azure-cli kubectl git
az login
```

### Repo Clone
```bash
git clone git@github.com:prusystems/aks-lab.git
cd aks-lab
```

### Terraform Init
```bash
terraform init
```

---

## 2️⃣ Deploy

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

Check outputs and note the resource group + cluster names.

---

## 3️⃣ Validate Cluster

```bash
az aks get-credentials --resource-group rg-lab --name aks-lab --overwrite-existing
kubectl get nodes
kubectl get pods -A
```

Expected result: one Ready node, version v1.30.x

---

## 4️⃣ Troubleshooting Checklist

- `Plugin did not respond` → rerun `terraform init`
- `kubectl: command not found` → install via Homebrew
- `Authentication failed` → refresh `az login` token
- Push error > 100 MB → `.gitignore .terraform/`

---

## 5️⃣ Teardown

```bash
terraform destroy -auto-approve
az group delete --name rg-lab --yes --no-wait
```

Verify deletion:
```bash
az group list --query "[?name=='rg-lab']"
```

---

## 6️⃣ Backup and Docs

1. Copy key configs → secure backup volume or encrypted cloud.
2. Commit clean repo (no state files).
3. Push to GitHub:
   ```bash
   git add .
   git commit -m "Final clean version"
   git push
   ```

---

## ✅ End State

Cluster deleted, costs $0/day.  
Documentation and IaC config preserved for future demo.
