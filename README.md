# Canvas

[Canvas](https://github.com/instructure/canvas-lms) on Github

## Install Canvas with Chef and Vagrant

    gem install vagrant
    vagrant up

The directory `shared` is mapped to the shared folder in the vagrant home dir.
It contains a file `runlist.json` which can be used when Vagrant has started the vm.

    vagrant ssh
    sudo chef-solo -j shared/runlist.json

## Improvements/todo

* Install under a different user (currently root)
* Do we really need the coffeescript recipe?

## Reference

* [Vagrant](http://vagrantup.com)
* [Chef](http://www.opscode.com/chef)
