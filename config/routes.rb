Rails.application.routes.draw do
  root 'welcome#index'

  resources :users do
    resources :relationships, only: [:create, :destroy]
    resources :rants, only: [:create, :destroy, :show]
    resources :profiles, only: [:show] do
      resources :rants, only: [:show]
    end
    member do
      get :followers, :following
    end
  end

  get  '/users/:user_id/favorites/', to: 'favorites#index', as: 'favorites'
  post '/favorites/:id', to: 'favorites#create', as: 'favorite'
  delete '/favorites/:id', to: 'favorites#destroy'

  resources :searches, only: [:index]

  resources :dashboards, only: [:show]

  resources :sessions, only: [:new, :create, :destroy]

end
