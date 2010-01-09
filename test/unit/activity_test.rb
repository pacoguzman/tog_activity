require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class ActivityTest < ActiveSupport::TestCase

  context "A activity" do
    setup do
      attributes = {:object_type => 'Graffity', :object_id => 1}
      @activity = Activity.new attributes.update(:actions => ['edited', 'revised'], :created_at => Time.zone.now)
      @others = [10, 70, 80].collect do |minutes_ago|
        actions = minutes_ago == 80 ? ['created'] : ['edited']
        Activity.new attributes.update(:actions => actions, :created_at => minutes_ago.minutes.ago)
      end

      @yesterdays = [Activity.new(attributes.update(:created_at => 1.day.ago))]
      @older = [Activity.new(attributes.update(:created_at => 2.days.ago))]

      @activities = [@activity] + @others + @yesterdays + @older
      @activities.sort!{|left, right| right.created_at <=> left.created_at }
    end

    context "associations" do
      subject { Activity.new }
      should_belong_to :object
      should_belong_to :author
    end

    context "validations" do
      subject { Activity.new }
      should_validate_presence_of :object
    end

    context "class methods" do
      should "#find_coinciding_grouped_by_dates finds coinciding activities grouped by given dates"
      #  test '#find_coinciding_grouped_by_dates finds coinciding activities grouped
      #        by given dates' do
      #    stub(Activity).find.returns @activities
      #    today, yesterday = Time.zone.now.to_date, 1.day.ago.to_date
      #    result = Activity.find_coinciding_grouped_by_dates today, yesterday
      #    result.should == [[@activity], @yesterdays, @older]
      #  end

      should "#find_coinciding finds activities and groups them to chunks coinciding within a given time delta,
             hiding grouped activities in @activity.siblings"
      #  test '#find_coinciding finds activities and groups them to chunks coninciding
      #        within a given time delta, hiding grouped activities in @activity.siblings' do
      #    stub(Activity).find.returns [@activity] + @others
      #    result = Activity.find_coinciding
      #    result.should == [@activity]
      #    result.first.siblings.should == @others
      #  end
    end

    context "instance methods" do
      should "#coincides_with?(other) is true when the compared created_at values
        differ by less/equal to the given delta value" do
        assert @activity.coincides_with?(@others.first)
#    @activity.coincides_with?(@others.first).should be_true        
      end

      should "#coincides_with?(other) is false when the compared created_at values
        differ by more than the given delta value" do
        assert !@activity.coincides_with?(@others.last)
#    @activity.coincides_with?(@others.last).should be_false
      end
      should "#from returns the last sibling's created_at value" do
        @activity.siblings = @others
        assert_equal @others.last.created_at, @activity.from
#    @activity.from.should == @others.last.created_at        
      end

      should "#to return the activity's created_at value" do
        @activity.siblings = @others
        assert_equal @activity.created_at, @activity.to
#    @activity.to.should == @activity.created_at
      end

      should "#all_actions returns all actions from all siblings in a chronological order" do
        @activity.siblings = @others
        assert_equal ['created', 'edited', 'revised'], @activity.all_actions
#    @activity.all_actions.should == ['created', 'edited', 'revised']        
      end

      should "when a missing method is called it looks for a corresponding key in object_attributes" do
        @activity.object_attributes = { 'foo' => 'bar' }
        assert_equal 'bar', @activity.foo
#    @activity.foo.should == 'bar'
      end
    end
  end
end