maintainer          "Zilverline BV"
maintainer_email    ""
license
description
#long_description    IO.read(File.join(File.dirname(__FILE__), '../../README.md'))
version

recipe "canvas::apt-sources", "Sets the ubuntu apt sources to the dutch archives"
recipe "canvas::git", "Installs git"
recipe "canvas::coffeescript", "Installs coffeescript"
recipe "canvas::db", "Creates databases for Canvas LMS"
recipe "canvas", "Installs Canvas LMS"

#depends "mysql"
#depends "java"
#depends "passenger_apache2"

supports "ubuntu"
