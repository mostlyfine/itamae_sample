node["users"].each do |u|
  user u["id"] do
    password u["password"]
    home u["home"]
  end

  if u["ssh-keys"]
    directory "#{u["home"]}/.ssh" do
      owner u["id"]
      group u["id"]
      mode "0700"
    end

    file "#{u["home"]}/.ssh/authorized_keys" do
      content u["ssh-keys"].join("\n")
      owner u["id"]
      group u["id"]
      mode "0600"
    end
  end
end

remote_file "/etc/sudoers" do
  source "templates/sudoers"
  owner "root"
  group "root"
end
