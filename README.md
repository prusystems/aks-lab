```markdown
# ☁️ AKS Terraform Lab  

## Overview  
Hands-on project demonstrating deployment of an **Azure Kubernetes Service (AKS)** cluster using **Terraform** from macOS.  
Covers provisioning, validation, troubleshooting, and teardown for cost-free lifecycle management.  

---

## Environment  

| Tool | Version | Purpose |
|------|----------|----------|
| macOS | Sonoma | Local dev environment |
| Terraform | 1.13.5 | IaC engine |
| Azure CLI | 2.79.0 | Auth & provisioning |
| kubectl | 1.32.9 | Cluster validation |
| Git + SSH | latest | Source control & automation |

---

## Workflow  

1. **Initialize project**
    **bash**
   brew install terraform azure-cli kubectl git
   az login
   terraform init
2. Define infrastructure in main.tf
* Resource Group → rg-lab
* AKS Cluster → aks-lab
Managed identity + node pool
3. Deploy
terraform plan
terraform apply
4. Validate cluster
az aks get-credentials --resource-group rg-lab --name aks-lab
kubectl get nodes
5. Destroy to avoid costs
terraform destroy
## Troubleshooting Highlights
| Error                      | Cause                 | Fix                                        |
| -------------------------- | --------------------- | ------------------------------------------ |
| Plugin did not respond     | Provider init glitch  | Re-`terraform init` + re-auth              |
| `az: executable not found` | CLI missing           | `brew install azure-cli`                   |
| File > 100 MB push fail    | Provider cached       | Add `.terraform/` to `.gitignore`          |
| APFS mount error           | Container mis-mounted | Erased via Disk Utility → APFS Container 1 |

## Security Hygiene
.gitignore excludes .terraform/, state, logs, and creds.
Used SSH auth → no plaintext tokens.
Confirmed teardown with az group list.
## Lessons Learned
AKS teardown ≈ 4 min avg (async Azure cleanup).
Keep state files local or encrypted remote.
Terraform + AKS demonstrates real-world cloud automation flow.
## Repo Structure
aks-lab/
├── main.tf
├── .gitignore
├── README.md
├── RUNBOOK.md
└── gitcheck.sh
**Author**
PruSystems
📧 contact@prusystems.com
🌐 prusystems.com
💻 github.com/prusystems
