require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class UserTest < ActiveSupport::TestCase

  ActiveRecord::Observer.disable_observers

  context "Activating a user" do
    setup do
      @user = Factory(:user)
      ActiveRecord::Observer.with_observers('activities/user_observer') do
        @user.activate!
      end
    end
    should_change("the number of activities", :by => 1){ Activity.count }
  end

  context "Destroying a user" do
    setup do
      ActiveRecord::Observer.with_observers('activities/user_observer') do
        @user = Factory(:member)
      end
    end
    should "destroy all its activities" do
      assert !@user.activities.empty?
      ActiveRecord::Observer.with_observers('activities/user_observer') do
        @user.destroy
      end
      assert @user.activities.empty?
    end
  end

#  def setup
#    super
#    #@site = Site.first
#    #@section = @site.sections.root
#    @user = User.first
#  end
#
#  # FIXME
#  # Can't get this to pass ... apparently RR has problems with expecting calls
#  # to dynamic methods?
#  #
#  # test "notify_subscribers sends emails to all subscribers" do
#  #   users = User.all
#  #   activity = Activity.new
#  #
#  #   stub(Activities::ActivityObserver).find_subscribers(activity).returns(users)
#  #   mock(ActivityNotifier).deliver_new_content_notification(anything, anything).times(users.size)
#  #
#  #   Activities::ActivityObserver.instance.after_create(activity)
#  # end
#
#  test "receives #notify_subscribers when an Article gets created" do
#    mock(Activities::ActivityObserver).notify_subscribers(is_a(Activity))
#
#    Activity.with_observers('activities/activity_observer') do
#      Article.with_observers('activities/article_observer') do
#        Article.create! :title => 'An article', :body => 'body',
#                        :author => @user, :site => @site, :section => @section
#      end
#    end
#  end
#
#  test "#find_subscribers returns only subscribed users" do
#    activity    = Activity.new(:site => @site)
#    subscribers = @site.users.find(:all, :include => :roles, :conditions => ['roles.name IN (?)', ['superuser', 'admin']])
#    assert_equal subscribers.count, Activities::ActivityObserver.send(:find_subscribers, activity).count
#  end
#
#  test "receives #notify_subscribers when a Comment gets created" do
#    mock(Activities::ActivityObserver).notify_subscribers(is_a(Activity))
#
#    Activity.with_observers('activities/activity_observer') do
#      Comment.with_observers('activities/comment_observer') do
#        Comment.create! :body => 'body', :author => @user, :commentable => Article.first,
#                        :site => @site, :section => @section
#      end
#    end
#  end
end