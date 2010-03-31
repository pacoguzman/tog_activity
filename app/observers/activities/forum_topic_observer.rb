module Activities
  class ForumTopicObserver < Activities::Logger
    observe TogForum::Topic

    logs_activity(:on => :created)

    def initialize_activity(record)
      returning super do |activity|
        activity.author = record.user
      end
    end
  end
end
