include_recipe "mysql::server"

::Chef::Resource::Bash.send(:include, SURFnet::Canvas::Helpers)

bash "create database user" do
    user "root"
    not_if(user_exists?(node[:canvas][:db][:user]))
    code create_user(node[:canvas][:db][:user], node[:canvas][:db][:password])
end

bash "create canvas database" do
    user "root"
    not_if(database_exists?(node[:canvas][:db][:name]))
    code create_database(node[:canvas][:db][:name], node[:canvas][:db][:user])
end

bash "create canvas queue database" do
    user "root"
    not_if(database_exists?(node[:canvas][:queue_db][:name]))
    code create_database(node[:canvas][:queue_db][:name], node[:canvas][:db][:user])
end
