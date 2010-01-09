module Activities
  class MembershipObserver < Activities::Logger
    observe :membership

    logs_activity do |log|
      log.activate :if => [:state_changed?, :active?]
    end

    def initialize_activity(record)
      returning super do |activity|
        activity.author = record.user
      end
    end
  end
end