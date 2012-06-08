cookbook_file "/etc/apt/sources.list" do
    source "sources.list"
    mode "0644"
    owner "root"
    group "root"
end

execute "update apt cache" do
    user "root"
    command "apt-get update"
end
