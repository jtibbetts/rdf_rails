Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  get 'docs/*path_to_hydra', to: 'documents#show'

# for the resources controller, assume the default action is 'show', so that resource IDs don't need the controller name in them
# When using this in your own application, watch out for possible clashes with routes for other controllers
  get '*anyroute', :controller => 'resources', :action=>'show'
  get  '*anyroute.:format', :controller => 'resources', :action=>'show'

end
