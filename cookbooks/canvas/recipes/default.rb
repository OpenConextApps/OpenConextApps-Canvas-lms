include_recipe "passenger_apache2"

%w{"zlib1g-dev" "libxml2-dev" "libxslt-dev" "libhttpclient-ruby" "imagemagick" "libcurl3-dev"}.each { |p|
    package p do
        action :install
    end
}

execute "clone-canvas-repo" do
    user "root"
    command "git clone https://github.com/instructure/canvas-lms.git /opt/canvas"
    creates "/opt/canvas"
end

template "/opt/canvas/.rvmrc" do
    source "rvmrc"
    mode "0644"
end

gem_package "bundler" do
    action :install
end

rvm_shell "bundle-install" do
    user "root"
    ruby_string "#{node[:canvas][:ruby][:version]}@#{node[:canvas][:ruby][:gemset]}"
    cwd "/opt/canvas"
    code "bundle install --without postgres"
end

template "/opt/canvas/config/database.yml" do
    source "database.yml.erb"
end

template "/opt/canvas/config/outgoing_mail.yml" do
    source "outgoing_mail.yml.erb"
end

template "/opt/canvas/config/security.yml" do
    source "security.yml.erb"
    action :create_if_missing
end

template "/opt/canvas/config/domain.yml" do
    source "domain.yml.erb"
end

rvm_shell "Canvas initial setup" do
    user "root"
    ruby_string "#{node[:canvas][:ruby][:version]}@#{node[:canvas][:ruby][:gemset]}"
    cwd "/opt/canvas"
    code "RAILS_ENV=test bundle exec rake db:initial_setup"
    not_if "test `mysql -uroot -p#{node[:mysql][:server_root_password]} -D#{node[:canvas][:db][:name]} -e 'show tables' | tail -n +2 | wc -l` -gt 0"
end

rvm_shell "Create admin user" do
    user "root"
    ruby_string "#{node[:canvas][:ruby][:version]}@#{node[:canvas][:ruby][:gemset]}"
    cwd "/opt/canvas"
    code "RAILS_ENV=test CANVAS_LMS_ADMIN_EMAIL=#{node[:canvas][:admin][:email]} CANVAS_LMS_ADMIN_PASSWORD=#{node[:canvas][:admin][:password]} bundle exec rake db:configure_admin"
end

rvm_shell "compile assets" do
    user "root"
    ruby_string "#{node[:canvas][:ruby][:version]}@#{node[:canvas][:ruby][:gemset]}"
    cwd "/opt/canvas"
    code "bundle exec rake canvas:compile_assets"
end

web_app "canvas" do
    docroot "/opt/canvas"
    server_name "canvas.#{node[:hostname]}"
    server_aliases [ node[:hostname] ]
    rails_env "test"
end
