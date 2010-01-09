ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'test_help'
require 'test/unit'
require 'mocha'

begin
  gem 'shoulda', '>=2.10.1'
  require 'shoulda' 
rescue Exception => e
  puts "\n\nYou need shoulda 2.10.1 or greater to test tog_activity. Visit http://github.com/thoughtbot/shoulda to view details.\n\n" 
  exit
end

begin
  gem 'no_peeping_toms', '>=1.1.0'
  require 'no_peeping_toms'
rescue Exception => e
  puts "\n\nYou need no_peeping_toms 1.1.0 or greater to test tog_activity. Visit http://github.com/patmaddox/no-peeping-toms to view details.\n\n"
  exit
end

require 'factory_girl'
require File.expand_path(File.dirname(__FILE__) + '/factories')

begin require 'redgreen'; rescue LoadError; end

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end