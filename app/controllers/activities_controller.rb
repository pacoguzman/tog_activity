class ActivitiesController < ApplicationController

  def index
    @page = params[:page] || '1'
    per_page = Tog::Config['plugins.tog_core.pagination_size']
    if params[:profile_id]
      @profile = Profile.find(params[:profile_id])
      @activities = @profile.user.activities.recent.paginate(:page => @page, :per_page => per_page)
    else
      @activities = Activity.recent.paginate(:page => @page, :per_page => per_page)
    end
  end

end