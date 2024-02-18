.PHONY: install
install:
	ansible-playbook playbooks/developer.yml --ask-become-pass --inventory ./playbooks/local-inventory

