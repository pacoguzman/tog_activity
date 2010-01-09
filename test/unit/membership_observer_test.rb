require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class MembershipTest < ActiveSupport::TestCase

  ActiveRecord::Observer.disable_observers

  context "Activating a membership" do
    setup do
      @user = Factory(:member)
      @group = Factory(:group, :author => @user)
      @group.activate!
      @membership = Factory(:membership, :group => @group, :user => @user)
      ActiveRecord::Observer.with_observers('activities/membership_observer') do
        @membership.activate!
      end
    end
    should_change("the number of activities", :by => 1){ Activity.count }
  end

end