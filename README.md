SpreeWarehouse
==============

Warehouse is an extension for Spree that will extend Spree into a full warehouse system, including an Android (and possibly iOS) client for inter-warehouse management using QR codes and bar-codes.
Please see the design document (still a work in progress) [here](https://docs.google.com/document/d/1K-C33WjH5GooNKW-GsW7-Ol_K4-7PbwVxPk3Vs2MmO0/edit).

Installation
=======
We support only Spree  >= 1.0.0

This branch is for version 1.1.x, for details check the Versionfile.

Install spree 1.1 

Include in your Gemfile: 

    gem 'spree_warehouse' , :git => 'git@github.com:Genshin/spree_warehouse.git'

And run: 

    $ bundle
    $ rake spree_warehouse:install:migrations 
    $ rake db:migrate
    $ rake spree_warehouse:db:seed
    $ rails s 


Testing
=======

Run `rake test_app` to generate the test_app.
Then run`rake` for the features and spec tests.

If you have problems try prefixing things with 'bundle exec '.



Copyright (c) 2012 Genshin Souzou Kabushiki Kaisha, released under the GNU GPL version 3
