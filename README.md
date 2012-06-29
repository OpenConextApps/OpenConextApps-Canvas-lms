# Canvas

[Canvas][canvas] can also be found on [Github][canvas-github].

## Install Canvas with Chef and Vagrant

### Install Vagrant
Vagrant depends on VirtualBox. You can download it from [here](http://www.virtualbox.org/wiki/Downloads).  
To install Vagrant download your os specific package from [Vagrant](http://downloads.vagrantup.com/).

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

### Conect to SURFconext
After the Vagrant virtual machine is running, your canvas should be ready to use SURFconext.

* saml.yml should be configured
* Add authorization with fingerprint and entity-id

### Access canvas
Once the vm is running you can access the Canvas application on port 80, or outside of the vm on localhost port 8080.
Because Canvas is running as a virtual host in apache, you should create a hosts entry with the vhost name (`canvas.lucid32`, by default),
so you can access Canvas as <http://canvas.lucid32:8080>.

## Improvements/todo

* Connect to SURFconext
* Use SSL certificate
* Install on real vm
* Whole word grep in user and db exists functions
* Can execute resource be used instead of bash in db.rb
    * Maybe write own resource/provider for create user and datbase
* Beat Sander with fußball

## Reference

* [Vagrant](http://vagrantup.com)
* [Chef](http://www.opscode.com/chef)

[canvas]: http://www.instructure.com
[canvas-github]: https://github.com/instructure/canvas-lms
