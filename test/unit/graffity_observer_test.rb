require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class GraffityTest < ActiveSupport::TestCase

  ActiveRecord::Observer.disable_observers

  if Desert::Manager.plugin_exists?("tog_wall")
    context "Creating a graffity" do
      setup do
        @user = Factory(:member)
        ActiveRecord::Observer.with_observers('activities/graffity_observer') do
          Factory(:graffity, :wall => @user.profile.wall, :profile => @user.profile)
        end
      end
      should_change("the number of activities", :by => 1){ Activity.count }
    end
  end

end