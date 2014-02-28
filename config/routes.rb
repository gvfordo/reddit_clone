RedditClone::Application.routes.draw do
  resources :users do

    resources :links, :only => [:new, :create, :index]

    resources :subs, :only => [:new, :create]

  end

  resources :links, :except => [:new, :create, :index]

  resources :subs, :except => [:new, :create]

  resource :session, :only => [:destroy, :create, :new]

end
