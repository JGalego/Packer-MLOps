# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "jgalego/mlops"
  config.vm.box_version = "0.1.0"

  # Access Jupyter web UI
  config.vm.network :forwarded_port, guest: 8888, host: 8888, id: "jupyter", auto_correct: true

  # Share a folder with the guest VM
  config.vm.synced_folder ENV.fetch('MLOPS_DATA', './data'), "/mlops_data"

  config.vm.provider "virtualbox" do |vb|
    # No GUI
    vb.gui = false
    # 3GB RAM
    vb.memory = "2048"
    vb.cpus = 1
  end

  config.vm.provision :shell, env: {"MLOPS_PASSWORD" => ENV.fetch('MLOPS_PASSWORD', 'mlops')}, inline: <<-SHELL
  # Generate an encrypted password for Jupyter
  SERVER_APP_PASSWORD="$(python3 -c "import os; from notebook.auth import passwd; print(passwd(os.environ['MLOPS_PASSWORD'], algorithm='sha1'))")"

  # Start Jupyter server
  jupyter lab --no-browser \
              --ServerApp.password="$SERVER_APP_PASSWORD" \
              --ServerApp.allow_origin="*" \
              --ServerApp.ip="0.0.0.0" \
              --allow-root \
              /mlops_data &
  SHELL
end
