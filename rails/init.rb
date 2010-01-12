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
ActiveRecord::Base.observers << 'activities/group_observer' if plugin_present?('tog_social')
ActiveRecord::Base.observers << 'activities/membership_observer' if plugin_present?('tog_social')