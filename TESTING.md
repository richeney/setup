# Testing Guide

## Testing on Ubuntu Noble (24.04) ARM64

This setup now uses official installation methods for Azure CLI, Terraform, Packer, and wslu that are compatible with Ubuntu Noble (24.04) on ARM64 architecture.

### Prerequisites

- Ubuntu 24.04 (Noble) on ARM64 architecture (e.g., Snapdragon Surface Laptop 7)
- WSL2 environment (if on Windows)
- Internet connection

### Testing the Bootstrap Process

1. **Run the bootstrap script:**
   ```bash
   bash <(curl -sSL https://raw.githubusercontent.com/richeney/setup/master/bootstrap.sh)
   ```

2. **Run the Ansible playbook:**
   ```bash
   ansible-playbook ~/ansible/playbook.yml
   ```

3. **Verify installations:**

   ```bash
   # Check Azure CLI
   az --version
   
   # Check Terraform
   terraform version
   
   # Check Packer
   packer version
   
   # Check wslu utilities
   wslview --help
   ```

### Architecture Detection

The playbook automatically detects the system architecture and uses the appropriate package repository:
- `aarch64` → `arm64` packages
- `x86_64` → `amd64` packages

### What Changed

**Before:** Custom Ansible roles hosted at:
- `richeney/ansible-azure-cli`
- `richeney/ansible-install-terraform`
- `richeney/ansible-install-packer`
- `richeney/ansible-install-wslu`

**After:** Direct installation from official sources:
- **Azure CLI**: Microsoft APT repository (`packages.microsoft.com`)
- **Terraform**: HashiCorp APT repository (`apt.releases.hashicorp.com`)
- **Packer**: HashiCorp APT repository (`apt.releases.hashicorp.com`)
- **wslu**: Official wslu PPA (`pkg.wslutiliti.es`)

### Known Compatible Versions

These official sources provide ARM64 packages for:
- Ubuntu 20.04 (Focal)
- Ubuntu 22.04 (Jammy)
- Ubuntu 24.04 (Noble)

### Rollback

If you need to revert to the Ansible roles version:

```bash
git checkout Ansible
```

The "Ansible" tag marks the last commit before switching to official installation scripts.

### Troubleshooting

**Issue**: GPG key import fails
- **Solution**: Ensure `curl` and `gpg` are installed: `sudo apt install curl gnupg`

**Issue**: Architecture not detected correctly
- **Solution**: Check `uname -m` output. Expected: `aarch64` for ARM64

**Issue**: Repository packages not found
- **Solution**: Run `sudo apt update` and check if the distribution release is supported

**Issue**: wsl_colours role not found
- **Solution**: Ensure `ansible-galaxy install -r ~/ansible/requirements.yml` completed successfully
