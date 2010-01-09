module Activities
  class UserObserver < Activities::Logger
    observe :user

    logs_activity do |log|
      log.activated :if => [:state_changed?, :recently_activated?]
    end

    def initialize_activity(record)
      returning super do |activity|
        activity.author = record
      end
    end

    def after_destroy(record)
      Activity.destroy_all(:author_id => record.id)
    end
  end
end