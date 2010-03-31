module ActivitiesHelper

  def public_continuum(size = 40)
    activity_list = Activity.recent.all(:limit=> size)
    show_continuum(activity_list)
  end

  def user_continuum(user, size = 10)
    activity_list = user.activities.recent.all(:limit=> size)
    show_continuum(activity_list)
  end

  def activity_partial(activity)
    #TODO only one action for activity
    "activities/#{activity.object_type.underscore}/#{activity.actions.first.to_s}"
  end

 def link_to_content(name, content, options = {})
    link_default = root_path
    link = case content.class.name
      when "User"
        profile_path(content.profile)
      when "Profile"
        profile_path(content)
      when "Blog"
        conversatio_blog_path(content)
      when "Post"
        conversatio_blog_post_path(content.blog, content.id)
      when "Comment"
        if content.commentable_type == "Post"
          conversatio_blog_post_path(:blog_id => content.commentable.blog, :id => content.commentable.id, :anchor => "comment_#{content.id}")
        elsif content.commentable_type == "Profile"
          profile = Profile.find(content.commentable_id)
          hashtag = if content.leaf?
            "reply_#{content.id}"
          else
            "comment_#{content.id}"
          end
          user_wall_path(:id => profile.user.id, :anchor => hashtag)
        end
      when "TogForum::Forum"
        forum_path(content)
      when "TogForum::Topic"
        forum_topic_path(content.forum, content)
      when "Picto::Photoset"
        picto_photoset_path(content)
      when "Picto::Photo"
        picto_photo_path(content)
      when "Group"
        options.reverse_merge!(:title => content.name)
        group_path(content)
      when "Upload"
        archive_upload_path(content.archive, content)
      else
        link_default
    end
    link_to(name, link, options)
  end

  private

  def show_continuum(activity_list)
    html = activity_list.collect do |activity|
      content_tag :li, :class => "clearfix" + cycle(nil, " pair") do
        render activity_partial(activity), {:a => activity}
      end
    end
    content_tag(:ul, html)
  end

  def activity_i18n_key(activity)
    #TODO only one action for activity
    scopes = ["activities"]
    scopes << activity.object_type.underscore.gsub("/","_")
    scopes << activity.actions.first
    if activity.object.class.to_s == 'Comment' && !activity.object.commentable_type.nil?
      scopes << activity.object.commentable_type.demodulize.downcase
    end
    scopes.join(".")
  end
end