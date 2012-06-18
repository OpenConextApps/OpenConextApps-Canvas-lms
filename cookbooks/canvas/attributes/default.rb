default[:canvas][:db][:name] = "canvas"
default[:canvas][:db][:user] = "canvas"
default[:canvas][:db][:password] = "canvas"
default[:canvas][:queue_db][:name] = "canvas_queue"

default[:canvas][:ruby][:version] = "1.8.7"
default[:canvas][:ruby][:gemset] = "canvas"

default[:canvas][:smtp][:host] = "localhost"
default[:canvas][:smtp][:port] = "25"
default[:canvas][:smtp][:user] = "user"
default[:canvas][:smtp][:password] = "password"
default[:canvas][:smtp][:delivery_method] = "sendmail" # sendmail, test
default[:canvas][:smtp][:authentication] = "plain" # plain, login, or cram_md5
default[:canvas][:smtp][:domain] = "canvas.surfnet.nl"
default[:canvas][:smtp][:outgoing_address] = "info-canvas@surfnet.nl"
default[:canvas][:smtp][:default_name] = "SURFnet Canvas"

default[:canvas][:security][:encryption_key] = "1234567890"

default[:canvas][:admin][:email] = "avandam@zilverline.com"
default[:canvas][:admin][:password] = "secret"

default[:canvas][:domain] = "localhost"
