class Activity < ActiveRecord::Base
  set_table_name 'log_activities'

  belongs_to :object, :polymorphic => true

  def method_missing_with_object_attributes(name, *args)
    attrs = self[:object_attributes]
    return attrs[name.to_s] if attrs && attrs.has_key?(name.to_s)
    method_missing_without_object_attributes name, *args
  end
  alias_method_chain :method_missing, :object_attributes

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"

  serialize :actions
  serialize :object_attributes

  validates_presence_of :author, :object

  attr_accessor :siblings

  named_scope :by_author, lambda { |authors|
    { :conditions => { :author_id => authors}}
  }

#  named_scope :by_action, lambda { |action|
#    { :conditions => { :action => action.to_s }}
#  }

  named_scope :by_object, lambda { |object|
    { :conditions => { :object_type => object.class.name, :object_id => object.id }}
  }

  named_scope :created_since, lambda { |time_ago|
    { :conditions => ['created_at > ?', time_ago]}
  }

  named_scope :created_before, lambda { |time_ago|
    { :conditions => ['created_at <= ?', time_ago]}
  }

  class << self
    def find_coinciding_grouped_by_dates(*dates)
      options = dates.extract_options!
      groups = (1..dates.size).collect{[]}
      activities = find_coinciding({:order => 'activities.created_at DESC', :limit => 50}.update(options)) #, :include => :user

      # collect activities for the given dates
      activities.each do |activity|
        activity_date = activity.created_at.to_date
        dates.each_with_index {|date, i| groups[i] << activity and break if activity_date == date }
      end

      # remove all found activities from the original resultset
      groups.each{|group| group.each{ |activity| activities.delete(activity) }}

      # push remaining resultset as a group itself (i.e. 'the rest of them')
      groups << activities
    end

    def find_coinciding(options = {})
      delta = options.delete(:delta)
      activities = find(:all, options).group_by{|r| "#{r.object_type}#{r.object_id}"}.values
      activities = group_coinciding(activities, delta)
      activities.sort{|a, b| b.created_at <=> a.created_at }
    end

    def group_coinciding(activities, delta = nil)
      activities.inject [] do |chunks, group|
        chunks << group.shift
        group.each do |activity|
          last = chunks.last.siblings.last || chunks.last
          if last.coincides_with?(activity, delta)
            chunks.last.siblings << activity
          else
            chunks << activity
          end
        end
        chunks
      end
    end
  end

  def after_initialize
    @siblings = []
  end

  def coincides_with?(other, delta = nil)
    delta ||= 1.hour
    created_at - other.created_at <= delta.to_i
  end

  # FIXME should be translated!
  def all_actions
    actions = Array(siblings.reverse.map(&:actions).compact.flatten) + self.actions
    previous = nil
    actions.reject! { |action| (action == previous).tap { previous = action } }
    actions
  end

  def from
    siblings.last.created_at if siblings.present?
  end

  def to
    created_at
  end
end
