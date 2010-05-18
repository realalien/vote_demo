authorization do
  role :guest do
    # add permissions for guests here, e.g.
    has_permission_on :survey_sheets, :to => [:create, :update]
  end
  
  
  # allow all the ops on guests/users or whatever 
  role :leader do
    has_permission_on :surveys, :to => :mamage
    
  end
  
  # permissions on other roles, such as
  role :admin do
    has_permission_on [:users ],  :to => :manage
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
