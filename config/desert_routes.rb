# Add your custom routes here.  If in config/routes.rb you would
# add <tt>map.resources</tt>, here you would add just <tt>resources</tt>

resources :activities, :only => [:index]
resources :profiles do |profile|
  profile.resources :activities, :only => [:index] 
end

