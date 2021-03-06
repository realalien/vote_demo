ActionController::Routing::Routes.draw do |map|
  map.resources :photo_categories

  map.resources :photos

  map.resources :teams

  map.resources :photo_categories

  map.resources :photos

  map.resources :sections

  map.resources :smerf_forms

  map.resources :answers

  map.resources :surveys do | survey |
  	survey.resources :questions
    survey.resources :sections
 end

  #map.resources :surveys, has_many => [ :questions ]
  #map.resources :questions

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.connect 'user/index', :controller => 'users', :action => 'index'
  
  map.resources :users do |user|
		  user.resources :votes
		  user.resources :travel_places do | travel_place |
				  travel_place.resources :votes
		  end
  end
  
  map.resource :session

  map.resources :travel_places do 
		 map.resources :votes
  end

  # for rating
  map.resources :questions, :member => {:rate => :post}
  map.resources :photos, :member => {:rate => :post}
  
  map.connect 'survey_sheets/:id/history', :controller => "survey_sheets" , :action => "history"
  
  map.resources :survey_sheets do | sheet |
    sheet.resources :responses
  end
  
  map.connect 'site/forward_to_employee_form', :controller => "site" ,:action=>'forward_to_employee_form' 
  #map.connect "survey_sheets/:action" , :controller => 'survey_sheets', :action => ':action'
  
    
  #map.connect 'ntlm/login', :controller => 'sessions', :action => 'new'

  map.connect 'user/vote_for/:id', :controller => :user,:action=>'vote_for'
 	
  map.connect 'zhang_jia_jie_photo_contest/:action', 
              :controller => 'zhang_jia_jie_photo_contest', 
              :action => ':action'  
  
  map.connect 'stat/report', :controller => 'stat', :action => "report"
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'sessions', :action => 'new'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #

  # Non-restful controller
  # map.connect 'survey_sheets/:action', :controller => 'survey_sheets'
  # resourceful routing.

  
  #map.connect 'survey_sheets/:id', :controller => "survey_sheets", :action => "show"
                                  # :conditions=> {:method => :get}

  #map.winlogin 'winlogin', :controller => 'sessions', :action => 'create_from_windows_login'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
