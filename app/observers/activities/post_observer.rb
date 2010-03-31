module Activities
  class PostObserver < Activities::Logger
    observe :post

    logs_activity do |log|
      log.publish :if => Proc.new { |p| p.state_was == "draft" && p.state == "published"}
    end

    def initialize_activity(record)
      returning super do |activity|
        activity.author = record.user
      end
    end
  end
end
