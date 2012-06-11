%w{"zlib1g-dev" "libxml2-dev" "libxslt-dev" "libhttpclient-ruby" "imagemagick"}.each { |p|
    package p do
        action :install
    end
}

execute "clone-canvas-repo" do
    command "git clone https://github.com/instructure/canvas-lms.git /opt/canvas"
    creates "/opt/canvas"
end

cookbook_file "/opt/canvas/.rvmrc" do
    source "rvmrc"
    mode "0644"
end

gem_package "bundler" do
    action :install
end

execute "bundle-install" do
    cwd "/opt/canvas"
    command "bundle install --without postgres"
end
