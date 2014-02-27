RedditClone::Application.routes.draw do
  resources :users
  resource :session, :only => [:destroy, :create, :new]
end
