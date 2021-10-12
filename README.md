# macos-provisioning
MacOS development environment provisioning

# Prerequisites
The following prerequisites are necessary:

## Install Homebrew and Ansible (run as elevated)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)”
```
```
brew install ansible
```

# Provisioning your machine (run as elevated)
```
ansible-playbook playbooks/developer.yml -i ./playbooks/local-inventory
```