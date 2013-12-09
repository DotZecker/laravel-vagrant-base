# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Configuración base del vagrant
    config.vm.box = "base"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    # Solventamos el problema de permisos en storage
    config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=666"]

    # Creamos un "alias" para acceder con más comodidad
    config.vm.network "private_network", ip: "192.168.56.101"
    config.vm.hostname = "lo.quetesalgadelos.dev"

    # Ejecutamos el script de instalación
    config.vm.provision :shell, :path => "install.sh"

end
