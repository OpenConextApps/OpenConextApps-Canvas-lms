# Canvas

[Canvas](https://github.com/instructure/canvas-lms) on Github

## Install Canvas with Chef and Vagrant

    gem install vagrant (or use the supplied .rvmrc file when using RVM)
    git submodule update
    vagrant up

The directory `shared` is mapped to the shared folder in the vagrant home dir.
It contains a file `runlist.json` which can be used when Vagrant has started the vm.

    vagrant ssh
    sudo chef-solo -j shared/runlist.json

## Improvements/todo

* Install under a different user (currently root)
* Do we really need the coffeescript recipe?
* Whole word grep in user and db exists functions
* Can execute resource be used instead of bash in db.rb
* Make the environment a variable in attributes
* Maybe add a not_if to fill database intial_setup of db
* Security possibility to randomize encryption_key
* Security.yml encryption_key is overwritten (only test??)
* Add more CPUs to Vagrant
* Config: delayed-jobs, file-store, ext_migration

## Reference

* [Vagrant](http://vagrantup.com)
* [Chef](http://www.opscode.com/chef)
