SpreeWarehouse
==============

Warehouse is an extension for Spree that will extend Spree into a full warehouse management system, including an Android (and possibly iOS) client for inter-warehouse management using QR codes and bar-codes.  
Please see the design document (still a work in progress) [here](https://docs.google.com/document/d/1K-C33WjH5GooNKW-GsW7-Ol_K4-7PbwVxPk3Vs2MmO0/edit).

Development
===========
Currently we are focusing on Spree 1.1.2 [Stable]. Older versions of Spree are somewhat unlikely to work, so attempt at your own risk.

Installation
============
In a Rails app with Spree installed include the following line in your Gemfile: 

    gem 'spree_warehouse' , :git => 'git://github.com/Genshin/spree_warehouse.git'

Then run the following commands: 

    $ bundle
    $ rake spree_warehouse:install:migrations 
    $ rake db:migrate
    $ rake spree_warehouse:db:seed
    $ rails s 


Testing
=======

Run `rake test_app` to generate the test_app.
Then run`rake` for the features and spec tests.

If you have problems try prefixing things with `bundle exec`.


Support
=======

    :irc => { :server => 'irc.freenode.org', :port => 6667, :channel => 'spree_warehouse' }



Copyright (c) 2012 Genshin Souzou Kabushiki Kaisha, dual licensed under the GNU GPL version 3 and AGPL version 3. Alternative licenses, including commercial and closed source licenses, can be granted upon consultation. To discuss licensing options please contact info@genshin.org .
