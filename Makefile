ANSIBLE_IMG_NAME = "ghcr.io/sebastianwebber/patroni-setup/ansible:main"
PROJECT_ROOT = $(shell pwd)

create-machines:
	vagrant up
	vagrant ssh-config > vagrant-ssh.cfg

ansible-ping: 
	./bin/ansible.sh -m ping -i inventory.yaml all

ansible-setup: 
	./bin/ansible-playbook.sh -i inventory.yaml playbook.yaml

ansible-img-name:
	@echo $(ANSIBLE_IMG_NAME)

project-root:
	@echo $(PROJECT_ROOT)

clean:
	vagrant destroy -f