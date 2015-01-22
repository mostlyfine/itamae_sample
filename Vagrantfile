VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.hostname  = 'itamae-skeleton'
  config.vm.synced_folder "./tmp", "/mnt/share", create: true

  config.vm.define :itamae do |c|
    c.vm.provider :virtualbox do |provider, override|
      provider.gui = false
      provider.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      provider.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]

      override.vm.box = "centos65"
      override.vm.box_url = "http://www.lyricalsoftware.com/downloads/centos65.box"
    end
  end
end
