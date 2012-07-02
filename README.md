# Project info

*You should be connected to SURFnet's network for this to work*

[Canvas][canvas] is a Learning Management System (LMS), also to be found on [Github][canvas-github]. This project aims to provide a simple set up for Canvas. It uses [Vagrant][Vagrant] and [Chef][chef] to create a virtual machine running Canvas in isolation. This way you can give Canvas a try without having to deal with its dependencies or setup configuration by yourself.

This cookbook is provided to you by [SURFnet][surfnet] and [Zilverline][zilverline]. It will integrate with SURFnet's Single Sign-on solution SURFConext. This way you can use a federative logon mechanism for your Canvas system.

Let's get started!

## 1: Install Canvas with Chef and Vagrant

### Install Vagrant
Vagrant depends on VirtualBox. You can download Virtualbox from [here](http://www.virtualbox.org/wiki/Downloads).
To install Vagrant download your OS specific package from [here](http://downloads.vagrantup.com/).

### Checkout and start VM

    git clone https://github.com/zilverline/chef-canvas.git
    git submodule init
    git submodule update
    vagrant up

After the VM has started and all the Chef cookbooks completed, you could suspend your vm.

    vagrant suspend

And to start the vm again.

    vagrant resume

Running the recipes again.

    vagrant provision

## 2: Check your attributes

Chef uses a set of attributes to configure the cookbooks. The default attributes can be found in `cookbooks/[cookbook_name]/attributes/default.rb`. You probably only want to look at the attributes of the Canvas cookbook (`cookbooks/canvas/attributes/default.rb`).

### Running with Vagrant
Overriding attributes while running Canvas with Vagrant can be done in the `Vagrantfile`.

    chef.json.merge!({
        :canvas => {
            :db => {
                :name => "canvas-test-db",
                :password => "123456"
            }
        }
        :mysql => { :server_root_password => "my_secret_password" }
    })

### Running with Chef Solo
Overriding attributes while running Canvas with chef-solo can be done in your `runlist.json`. An example can be found in the chef-solo directory.

## 3: Connect to SURFconext
After the Vagrant virtual machine is running, your canvas should be ready to use SURFconext. Please contact the SURFconext team for what information to be able to successfully use SURFConext.

The location of the consumer service of canvas is `https://[CANVAS_HOST]/saml_consume` and your connection id/entity id needs to be the same. Canvas entity id is a chef attribute `default[:canvas][:auth][:saml][:entity_id]`.

## 4: Access canvas
Once the vm is running you can access the Canvas application on port 80, or outside of the vm on localhost port 8080.
Because Canvas is running as a virtual host in Apache, you should create a hosts entry with the vhost name (`canvas.lucid32`, by default).

    $ cat /etc/hosts
    127.0.0.1localhost canvas.lucid32

Then it should be possilbe to go with your browser to <http://canvas.lucid32:8080> on your local machine and see the Canvas application.

If you are not able to login to Canvas through SURFconext you can always use the admin user. Check the chef attrubutes `default[:canvas][:admin][:email]` and `default[:canvas][:admin][:password]` for the admin login credentials. You can then use these on the login page <http://canvas.lucid32:8080/login?canvas_login=1>.

## 5: Have fun!
This should result in a smoothly running Canvas instance. For how to configure Canvas you can best take a look at the [Canvas documentation][canvas-wiki] itself. In case of questions about this project, please let us know.

## Noteworthy
Canvas - by design - does not support automated provisioning of users. A user record should be created in the Canvas system before he can enter the LMS. This means that even though SURFConext (or a identity provider of your choice) can be used for federative logon your system administrator should first add this user to the Canvas database and define the user's role. Be sure when using SURFConext the user's login in Canvas should be identical to the user's FOOBAR in SURFConext.

## Running without Vagrant
The project also contains a chef-solo directory. The directory contains a script `run.sh` which can be used to run chef-solo without using Vagrant. The `runlist.json` contains the recipe list and the overrides for the default attributes

## Improvements/todo

* Can execute resource be used instead of bash in db.rb
    * Maybe write own resource/provider for create user and datbase

## Reference

* [Chef][chef]
* [Vagrant][vagrant]

[canvas]: http://www.instructure.com
[canvas-github]: https://github.com/instructure/canvas-lms
[canvas-wiki]: https://github.com/instructure/canvas-lms/wiki
[chef]: (http://www.opscode.com/chef)
[surfnet]: (http://www.surfnet.nl)
[vagrant]: (http://vagrantup.com)
[zilverline]: (http://www.zilverline.com)
