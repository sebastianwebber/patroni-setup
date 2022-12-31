MAX_NODES = 3
SSH_KEY = File.expand_path("./images/rocky9-ansible/local-cluster-rsa-key")
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

unless File.exists?(SSH_KEY)
    puts
    puts "local key not found, creating a new one..."
    system("ssh-keygen -t rsa -b 4096 -f #{SSH_KEY} -N ''")

    puts
end

Vagrant.configure("2") do |config|
  (1..MAX_NODES).each do |id|
    config.vm.define "db-node-#{id}" , primary: true do |subconfig|
        subconfig.vm.synced_folder '.', '/vagrant', disabled: true
        subconfig.ssh.private_key_path = SSH_KEY
        subconfig.vm.hostname = "db-node-#{id}"
        subconfig.vm.provider "docker" do |d|
            d.build_dir = "./images/rocky9-ansible"
            d.has_ssh = true
            d.privileged = true
        end
    end
  end
end