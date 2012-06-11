case node[:platform]
when "debian", "ubuntu"
    package "git-core"
when "centos", "redhat", "scientific", "fedora"
    package "git"
else
    package "git"
end
