include_recipe "build-essential"
include_recipe "nodejs"

package "curl"

execute "install npm" do
    command "curl http://npmjs.org/install.sh | sh"
    not_if "`which npm`"
end

execute "install coffee-script" do
    command "npm install -g coffee-script"
    not_if "`which coffee`"
end
