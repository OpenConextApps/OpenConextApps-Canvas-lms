package "python-software-properties"

execute "Add ruby repository" do
    user "root"
    command "apt-add-repository ppa:maco.m/ruby && apt-get update"
end

%w[ruby ruby-dev].each { |p|
    package p do
        action :install
        #version "1.8.7"
    end
}

# only needed for ubuntu and debian?
bash "Add ruby gems binary to path" do
    user "root"
    creates "/etc/profile.d/rubygems1.8.sh"
    code <<-EOH
    echo "PATH=/var/lib/gems/1.8/bin:$PATH" > /etc/profile.d/rubygems1.8.sh
    EOH
end

package "rubygems"

gem_package "bundler" do
    gem_binary "/usr/bin/gem"
    #node[:languages][:ruby][:gem_bin]
end
