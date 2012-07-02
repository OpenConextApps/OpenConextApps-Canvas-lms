module SURFnet
    module Canvas
        module Helpers

            def database_exists?(database)
                "/usr/bin/mysql -uroot -p#{node[:mysql][:server_root_password]} -e 'show databases' | grep -w #{database}"
            end

            def user_exists?(user)
                "/usr/bin/mysql -uroot -p#{node[:mysql][:server_root_password]} -e 'select user from mysql.user' | grep -w #{user}"
            end

            def create_user(username, password)
                run_as_mysql_root("create user '#{username}'@'localhost' identified by '#{password}'")
            end

            def create_database(database, username)
                script = ""
                script << run_as_mysql_root("create database #{database}") << "\n"
                script << run_as_mysql_root("grant all privileges on #{database}.* to '#{username}'@'localhost' with grant option")
                script
            end

            def run_as_mysql_root(script)
                "mysql -uroot -p#{node[:mysql][:server_root_password]} -e \"#{script}\""
            end
        end
    end
end
