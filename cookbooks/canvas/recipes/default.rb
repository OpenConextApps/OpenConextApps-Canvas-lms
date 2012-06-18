include_recipe "git"
include_recipe "passenger_apache2::mod_rails"

%w[zlib1g-dev libxml2-dev libxslt-dev libhttpclient-ruby imagemagick libcurl3-dev].each { |p|
    package p
}

group node[:canvas][:group]

user node[:canvas][:user] do
    comment "Canvas LMS User"
    gid "canvas"
    home "/opt/canvas"
    shell "/bin/false"
end

execute "clone-canvas-repo" do
    user "root"
    command "git clone https://github.com/instructure/canvas-lms.git /opt/canvas && chown -R canvas:canvas /opt/canvas"
    creates "/opt/canvas"
end

execute "bundle-install" do
    user "root"
    cwd "/opt/canvas"
    command "bundle install --without postgres"
end

%w[database.yml outgoing_mail.yml security.yml domain.yml].each { |config_file|
    template "/opt/canvas/config/" + config_file do
        owner node[:canvas][:user]
        group node[:canvas][:group]
        mode "0640"
        source config_file + ".erb"
    end
}

bash "Canvas initial setup" do
    user node[:canvas][:user]
    cwd "/opt/canvas"
    code "RAILS_ENV=#{node[:canvas][:ruby][:env]} rake db:initial_setup"
    not_if "test `mysql -uroot -p#{node[:mysql][:server_root_password]} -D#{node[:canvas][:db][:name]} -e 'show tables' | tail -n +2 | wc -l` -gt 0"
end

bash "Create admin user" do
    user node[:canvas][:user]
    cwd "/opt/canvas"
    code "RAILS_ENV=#{node[:canvas][:ruby][:env]} CANVAS_LMS_ADMIN_EMAIL=#{node[:canvas][:admin][:email]} CANVAS_LMS_ADMIN_PASSWORD=#{node[:canvas][:admin][:password]} rake db:configure_admin"
end

execute "compile assets" do
    user node[:canvas][:user]
    cwd "/opt/canvas"
    command "rake canvas:compile_assets"
end

web_app "canvas" do
    docroot "/opt/canvas/public"
    server_name "canvas.#{node[:hostname]}"
    server_aliases [ node[:hostname] ]
    rails_env "#{node[:canvas][:ruby][:env]}"
end
