module Activities
  class BlogObserver < Activities::Logger
    observe :blog

    logs_activity(:on => :created)

  end
end
