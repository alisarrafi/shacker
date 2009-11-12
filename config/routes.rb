ActionController::Routing::Routes.draw do |map|

  map.connect 'facebook.js', :controller => 'bruteforce', :action => 'client', :option => 'facebook'

  map.connect 'solution/:client', :controller => 'bruteforce', :action => 'solution'
  map.connect 'statistics/:sort/:updown', :controller => 'bruteforce', :action => 'statistics'

  map.connect ':action',         :controller => 'bruteforce'
  map.connect ':action.:format', :controller => 'bruteforce'

  map.root :controller => 'bruteforce'
    
end
