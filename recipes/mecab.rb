execute "install groonga repository" do
  command "rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm"
  not_if "rpm -qa | grep groonga"
end

package "mecab"
package "mecab-devel"
package "mecab-ipadic"


