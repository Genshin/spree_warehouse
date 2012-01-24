SpreeWarehouse
==============

Warehouse is an extension for Spree that will extend Spree into a full warehouse system, including an Android (and possibly iOS) client for inter-warehouse management using QR codes and bar-codes.
Please see the design document (still a work in progress) [here](https://docs.google.com/document/d/1K-C33WjH5GooNKW-GsW7-Ol_K4-7PbwVxPk3Vs2MmO0/edit).

Installation
=======

After including `spree_warehouse` in your Gemfile and bundling run:
``rake spree_warehouse:install:migrations
rake db:migrate
``

Testing
-------

Run `rake test_app` to generate the test_app.
Then run rake to run the features and spec tests.



Copyright (c) 2012 Genshin Souzou Kabushiki Kaisha, released under the GNU GPL version 3
