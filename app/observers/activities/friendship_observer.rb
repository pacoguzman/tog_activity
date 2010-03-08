module Activities
  class FriendshipObserver < Activities::Logger
    observe :friendship
 
    logs_activity do |log|
      log.friends :if => Proc.new { |f| f.status_was == Friendship::PENDING && f.status == Friendship::ACCEPTED }
      #log.unfriends :if => Proc.new {|f| f.status_changed? && f.status == Friendship::ACCEPTED}
    end

    def initialize_activities(record)
      returning [] do |activities|
        activities << initialize_activity(record, record.inviter.user, record.invited.user)
        activities << initialize_activity(record, record.invited.user, record.inviter.user)
      end
    end

    def initialize_activity(record, author, object)
      returning super(record) do |activity|
        activity.author = author
        activity.object = object
      end
    end
  end
end