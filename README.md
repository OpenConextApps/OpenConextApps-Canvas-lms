# Canvas

[Canvas](https://github.com/instructure/canvas-lms) on Github

## Install Canvas with Chef and Vagrant

### Install Vagrant
Vagrant depends on VirtualBox. You can download it from [here](http://www.virtualbox.org/wiki/Downloads).  
To install Vagrant download your os specific package from [Vagrant](http://downloads.vagrantup.com/).

### Checkout and start VM

    git clone https://github.com/zilverline/chef-canvas.git
    git submodule init
    git submodule update
    vagrant up

After the VM is running and all the Chef Cookbooks ran you could suspend your vm.

    vagrant suspend

And to start the vm again

    vagrant resume

Running the recipes again

    vagrant provision

### Start canvas
After the vm has started and the cookbooks ran you should be able to start canvas `cd /opt/canvas;RAILS_ENV=test scripts/server` and access it on [http://localhost:3000](http://localhost:3000).

## Improvements/todo

* Connect to SURFconext
* Use SSL certificate
* Install on real vm
* Whole word grep in user and db exists functions
* Config files needed?
    * delayed-jobs
    * file-store
    * ext_migration
* Can execute resource be used instead of bash in db.rb
    * Maybe write own resource/provider for create user and datbase
* Beat Sander with fußball

## Reference

* [Vagrant](http://vagrantup.com)
* [Chef](http://www.opscode.com/chef)
