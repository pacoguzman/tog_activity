module Activities
  class GroupObserver < Activities::Logger
    observe :group

    logs_activity do |log|
      log.activated :if => [:state_changed?, :active?]
    end

  end
end  