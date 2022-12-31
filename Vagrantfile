require "yaml"

def compute_max_nodes(inventory_file = "./inventory.yaml")
  default_nodes = ENV["MAX_NODES"].to_s.empty? ? 3 : ENV["MAX_NODES"].to_i
  file_content = YAML.load_file(inventory_file) rescue {}

  return default_nodes unless file_content.has_key? "all"
  return default_nodes unless file_content["all"].has_key? "hosts"

  return file_content["all"]["hosts"].keys.count
end

def update_inventory(new_inventory_content, inventory_file = "./inventory.yaml")
  File.write(inventory_file, new_inventory_content.to_yaml)
end

MAX_NODES = compute_max_nodes
SSH_KEY = File.expand_path("./images/rocky9-ansible/local-cluster-rsa-key")
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

unless File.exists?(SSH_KEY)
    puts
    puts "local key not found, creating a new one..."
    system("ssh-keygen -t rsa -b 4096 -f #{SSH_KEY} -N ''")

    puts
end

inventory_file = {
  "all" => {
    "hosts" => {}
  }
}

Vagrant.configure("2") do |config|
  (1..MAX_NODES).each do |id|
    node_name = "db-node-#{id}"
    inventory_file["all"]["hosts"][node_name] = nil

    config.vm.define node_name, primary: true do |subconfig|
        subconfig.vm.synced_folder '.', '/vagrant', disabled: true
        subconfig.ssh.private_key_path = SSH_KEY
        subconfig.vm.hostname = "db-node-#{id}"
        subconfig.vm.provider "docker" do |d|
            d.build_dir = "./images/rocky9-ansible"
            d.has_ssh = true
            d.privileged = true
        end
    end

    update_inventory(inventory_file)
  end
end
