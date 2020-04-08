Rails.application.routes.draw do
  # default_url_options Rails.application.config.action_mailer.default_url_options
  resources :escape_games do
    delete '/images/:id', to: 'images#destroy', as: :image
    put '/images/:id', to: 'images#default', as: :default_image
  end
  resources :clears do
    delete '/images/:id', to: 'images#clear_destroy', as: :image
  end
  get 'explore', to: 'escape_games#explore'
  put 'escape_games/:id/cleared', to: 'escape_games#cleared', as: :escape_game_cleared
  resources :users, except: :index
  get 'sessions/new'
  get 'sessions/destroy'
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  # get 'auth/auth0/callback' => 'auth0#callback'
  # get 'auth/failure' => 'auth0#failure'

  devise_for :users, skip: [:sessions], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_in', :to => 'home#index', :as => :new_user_session
    get 'sign_out', :to => 'sessions#destroy', :as => :destroy_user_session
    post 'maintainer', :to => 'users#maintainer', :as => :make_user_maintainer
    post 'enthusiast', :to => 'users#enthusiast', :as => :make_user_enthusiast
    post 'both', :to => 'users#maintainer_and_enthusiast', :as => :make_maintainer_and_enthusiast
  end
end
