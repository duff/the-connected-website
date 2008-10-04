ActionController::Routing::Routes.draw do |map|
  map.resources :users, :member => { :become => :post }, :collection => { :all => :get }
  map.resources :sessions
  map.resources :posts, :has_many => [ :comments, :topics ], :member => { :feature => :put, :unfeature => :put }, :collection => { :featured => :get }
  map.resources :topics
  map.resource  :settings, :collection => { :save_new_avatar => :put, :picture => :get, :username_email => :any, :bio => :any, :password => :any }

  map.login '/login', :controller => "sessions", :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.forgot_password '/login/forgot_password', :controller => 'sessions', :action => 'forgot_password'
  map.reset_password 'rp/:reset_password_token', :controller => "sessions", :action => 'reset_password'
  map.admin_emails 'admin/emails', :controller => 'admin', :action => 'emails'
  
  map.info 'info/:action', :controller => 'info'
  
  map.root :controller => "home"
  
end

