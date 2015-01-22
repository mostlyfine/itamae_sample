#
# for CentOS 6.x
#

execute "install remi repository" do
  command "rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
  not_if "rpm -qa | grep remi"
end

service "mysqld" do
  action :stop
  only_if "service mysql"
end

execute "remove installed mysql" do
  command "yum remove -y mysql"
  only_if "rpm -qa | grep mysql"
end

%w(mysql mysql-server mysql-devel).each do |pkg|
  package pkg do
    action :install
    options "--enablerepo remi"
  end
end

service "mysqld" do
  action [:enable, :start]
end

execute "set root password" do
  command "mysqladmin -u root password #{node['mysql']['server_root_password']}"
  only_if "mysql -u root -e 'show databases;'"
end
