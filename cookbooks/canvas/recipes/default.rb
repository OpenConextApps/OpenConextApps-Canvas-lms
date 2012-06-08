%w{"zlib1g-dev" "libxml2-dev" "libxslt-dev" "libsqlite3-dev" "libhttpclient-ruby" "imagemagick"}.each { |p|
    package p do
        action [:install]
    end
}

execute "clone-canvas-repo" do
    command "git clone https://github.com/instructure/canvas-lms.git /opt/canvas"
    creates "/opt/canvas"
end
