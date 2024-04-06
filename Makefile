.PHONY: provision
provision: install-deps
	ansible-playbook playbooks/developer.yml --ask-become-pass --inventory ./playbooks/local-inventory

.PHONY: install-deps
install-deps:
	which brew 2>&1 1>/dev/null || sudo /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	which ansible 2>&1 1>/dev/null || brew install ansible
