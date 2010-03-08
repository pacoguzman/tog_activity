require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class FriendshipTest < ActiveSupport::TestCase

  ActiveRecord::Observer.disable_observers

  if Desert::Manager.plugin_exists?("tog_social")
    context "Two members make friends" do
      setup do
        @user = Factory(:member)
        @friend = Factory(:member)
        ActiveRecord::Observer.with_observers('activities/friendship_observer') do
          @user.profile.add_follower(@friend.profile)
          @friend.profile.add_follower(@user.profile)
        end
      end
      should_change("the number of activities", :by => 2){ Activity.count }
    end

    context "One member follows other member" do
      setup do
        @user = Factory(:member)
        @friend = Factory(:member)
        ActiveRecord::Observer.with_observers('activities/friendship_observer') do
          @user.profile.add_follower(@friend.profile)
        end
      end
      should_not_change("the number of activities"){ Activity.count }
    end

  end
end