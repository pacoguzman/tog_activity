require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class DesertExtTest < ActiveSupport::TestCase

  test 'Desert::Plugin should have observers_path method' do
    assert Desert::Plugin.new('tog_activity').respond_to?(:observers_path)
  end

  test 'Desert::Manager should have register_plugin_with_observers method' do
    assert Desert::Manager.new.respond_to?(:register_plugin_with_observers)      
  end
end