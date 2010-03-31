module Activities
  class CommentObserver < Activities::Logger
    observe :comment

    logs_activity(:on => :created)

    def initialize_activity(record)
      returning super do |activity|
        activity.author = record.user
      end
    end
  end
end
