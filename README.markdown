Tog Activity
========

* Inspired and based in [adva_activity](http://github.com/svenfuchs/adva_cms/tree/master/engines/adva_activity/)
* Inspired too in [has_streams](http://github.com/fnando/has_streams/)

WORK IN PROGRESS

Scope
-------

* Define the report/record/log of activities in only one place throught activities observers
* Define the views of each activity separately with partials
* Define the messages of each activity in one place - I18n support
* Maybe define filters through an yml file to show specific activities

Notes
-----

* In activities views you must define the helper used to show an icon.

Resources
=========

Gem requirements for test environment
--------------------------------------

* http://github.com/patmaddox/no-peeping-toms/

Install
-------

* Install plugin form source:

<pre>
ruby script/plugin install git://github.com:pacoguzman/tog_activity.git
</pre>

* Generate installation migration:

<pre>
ruby script/generate migration install_tog_activity
</pre>

	  with the following content:

<pre>
class InstallTogActivity < ActiveRecord::Migration
  def self.up
    migrate_plugin "tog_activity", 1
  end

  def self.down
    migrate_plugin "tog_activity", 0
  end
end
</pre>

* Add this require just below require 'desert' in the environment.rb file, with this desert handle correctly the observers used in tog_activity

<pre>
require File.join("#{Rails.root}", "vendor", "plugins", "tog_activity", "lib", "desert_ext", "with_observers")
</pre>


More
-------

[http://github.com/pacoguzman/tog_activity](http://github.com/pacoguzman/tog_activity)

[http://github.com/pacoguzman/tog_activity/wikis](http://github.com/pacoguzman/tog_activity/wikis)


Copyright (c) Paco Guzman, released under the MIT license
