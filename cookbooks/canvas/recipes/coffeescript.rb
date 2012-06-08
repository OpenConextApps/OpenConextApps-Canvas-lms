%w{"build-essential" "curl"}.each { |p|
    package p do
        action [:install]
    end
}

execute "checkout-node" do
    command "git clone https://github.com/joyent/node.git /opt/node"
    creates "/opt/node" 
end

execute "install-node" do
    cwd "/opt/node"
    user "root"
    command "./configure && make && make install"
    not_if "`which node`"
end

execute "install-npm" do
    command "curl http://npmjs.org/install.sh | sh"
    not_if "`which npm`"
end

execute "install-coffee-script" do
    command "npm install -g coffee-script"
    not_if "`which coffee`"
end
