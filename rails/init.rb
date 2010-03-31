# Include hook code here
#require 'tog_activity'
require 'rails_ext'
require 'desert_ext'

require_plugin 'tog_core'
require_plugin 'tog_user'

Dir[File.dirname(__FILE__) + '/../locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

Tog::Plugins.helpers ActivitiesHelper

ActiveRecord::Base.observers += %w( activities/activity_observer activities/user_observer )
ActiveRecord::Base.observers << 'activities/graffity_observer' if plugin_present?('tog_wall')
if plugin_present?('tog_social')
  ActiveRecord::Base.observers << 'activities/group_observer'
  ActiveRecord::Base.observers << 'activities/membership_observer'
  ActiveRecord::Base.observers << 'activities/friendship_observer'
end
if plugin_present?('tog_conversatio')
  ActiveRecord::Base.observers << 'activities/blog_observer'
  ActiveRecord::Base.observers << 'activities/post_observer'
  ActiveRecord::Base.observers << 'activities/comment_observer'
end
if plugin_present?('tog_forum')
  ActiveRecord::Base.observers << 'activities/forum_topic_observer'
  ActiveRecord::Base.observers << 'activities/forum_post_observer'
end
