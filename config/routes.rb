ActionController::Routing::Routes.draw do |map|

  map.connect 'solution/:password', :controller => 'bruteforce', :action => 'solved'
  
  map.connect ':action', :controller => 'bruteforce'
  map.connect ':action.:format', :controller => 'bruteforce'
  
  map.root :controller => 'bruteforce'
  
end
