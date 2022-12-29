create-machines:
	vagrant up
	vagrant ssh-config > vagrant-ssh.cfg

ansible-ping:
	pipenv run ansible -m ping -i inventory.yaml all

ansible-setup:
	pipenv run ansible-playbook -i inventory.yaml playbook.yaml

clean:
	vagrant destroy -f