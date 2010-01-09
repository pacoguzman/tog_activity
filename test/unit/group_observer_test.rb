require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class GroupTest < ActiveSupport::TestCase

  ActiveRecord::Observer.disable_observers

  context "Activating a group" do
    setup do
      @user = Factory(:member)
      @group = Factory(:group, :author => @user)
      ActiveRecord::Observer.with_observers('activities/group_observer') do
        @group.activate!
      end
    end
    should_change("the number of activities", :by => 1){ Activity.count }
  end

end