module Activities
  class GraffityObserver < Activities::Logger
    observe :graffity

    logs_activity(:on => :created)

    def initialize_activity(record)
      returning super do |activity|
        #activity.site = record.commentable.site
        #activity.section = record.commentable.section
        activity.author = record.profile.user
      end
    end
  end
end
