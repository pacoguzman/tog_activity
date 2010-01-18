module ActivitiesHelper

  def public_continuum(size = 40)
    Activity.find(:all, :limit=> size, :order => " created_at DESC").collect do |a|
      content_tag :li, :class => "clearfix" + cycle(nil, " pair") do
        render activity_partial(a), {:a => a}
      end
    end 
  end

  def activity_partial(activity)
    #TODO only one action for activity
    "activities/#{activity.object_type.underscore}/#{activity.actions.first.to_s}"
  end
  
private
  def activity_i18n_key(activity)
    #TODO only one action for activity
    scopes = ["activities"]
    scopes << activity.object_type.underscore.gsub("/","_")
    scopes << activity.actions.first
    if activity.object.is_a?(Comment) && !activity.object.commentable_type.nil?
      scopes << activity.object.commentable_type.demodulize.downcase
    end
    key = scopes.join(".")
  end
end