package "python-software-properties"

execute "Add ruby repository" do
    user "root"
    command "apt-add-repository ppa:maco.m/ruby && apt-get update"
end

%w{"ruby" "ruby-dev"}.each { |p|
    package p do
        action :install
        #version "1.8.7"
    end
}

package "rubygems"

gem_package "bundler" do
  action :install
  gem_binary "/usr/bin/gem"
end

