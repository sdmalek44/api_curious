Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :users, only: [:show]
  get '/dashboard', to: "dashboard#index"
  resources :repos, only: [:index]
  resources :followings, only: [:index]
  get '/following', to: 'followings#show'
  get '/recent_activity', to: 'recent_activity#index'
  resources :organizations, only: [:index]
end
