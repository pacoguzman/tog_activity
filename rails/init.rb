# Include hook code here
#require 'tog_activity'
require 'rails_ext'
require 'desert_ext'

require_plugin 'tog_core'
require_plugin 'tog_user'

Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

#Tog::Plugins.helpers WallsHelper

ActiveRecord::Base.observers += %w( activities/activity_observer activities/user_observer )
ActiveRecord::Base.observers << 'activities/graffity_observer' if plugin_present?('tog_wall')
ActiveRecord::Base.observers << 'activities/group_observer' if plugin_present?('tog_social')
ActiveRecord::Base.observers << 'activities/membership_observer' if plugin_present?('tog_social')

#ActiveRecord::Base.observers += %w( activities/activity_observer activities/article_observer activities/section_observer )
#ActiveRecord::Base.observers << 'activities/comment_observer'  if Rails.plugin?(:adva_comments)
#ActiveRecord::Base.observers << 'activities/topic_observer'    if Rails.plugin?(:adva_forum)
#ActiveRecord::Base.observers << 'activities/wikipage_observer' if Rails.plugin?(:adva_wiki)
