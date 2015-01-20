%w{
git
gcc
openssl-devel
readline-devel
gdbm-devel
db4-devel
libffi-devel
libyaml-devel
tk-devel
zlib-devel
}.each do |pkg|
  package pkg
end

rbenv_path    = "/home/#{node["rbenv"]["user"]}/.rbenv"
plugin_path   = "#{rbenv_path}/plugins"
rbenv_command = "#{rbenv_path}/bin/rbenv"

git rbenv_path do
  repository node["rbenv"]["repository"]
  user node["rbenv"]["user"] if node["rbenv"]["user"]
  not_if File.exists? rbenv_path
end

template "/etc/profile.d/rbenv.sh" do
  source "templates/rbenv.sh.erb"
  variables rbenv_path: rbenv_path
end

directory plugin_path do
  owner node["rbenv"]["user"]
  group node["rbenv"]["group"] || node["rbenv"]["user"]
  mode "0755"
  action :create
  not_if File.exists? plugin_path
end

node["rbenv"]["plugins"].each do |plgin|
  git "#{plugin_path}/#{plgin["name"]}" do
    repository plgin["repository"]
    user node["rbenv"]["user"]
    not_if File.exists? "#{plugin_path}/#{plgin["name"]}"
  end
end

node["rbenv"]["versions"].each do |version|
  execute "Install Ruby v#{version}" do
    user node["rbenv"]["user"]
    command "#{rbenv_command} install #{version}"
    not_if "#{rbenv_command} versions | grep #{version}"
  end
end

execute "Set global ruby version #{node["rbenv"]["global_version"]}" do
  user node["rbenv"]["user"]
  command "#{rbenv_command} global #{node["rbenv"]["global_version"]}"
end
