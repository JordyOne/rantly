Rails.application.routes.draw do
  root 'welcome#index'

  resources :users do
    resources :relationships, only: [:create, :destroy]
    resources :rants, only: [:create, :destroy, :show] do
      resources :comments, only: [:create, :destroy]
      member do
        patch :spam
      end
    end
    resources :profiles, only: [:show] do
      resources :rants, only: [:show]
    end
    member do
      get :followers, :following
    end
  end

  delete '/users/:user_id/rants/:id/spam', to: 'rants#unspam'

  get '/users/:user_id/favorites/', to: 'favorites#index', as: 'favorites'
  post '/favorites/:id', to: 'favorites#create', as: 'favorite'
  delete '/favorites/:id', to: 'favorites#destroy'

  resources :searches, only: [:index]

  resources :dashboards, only: [:show]

  resources :sessions, only: [:new, :create, :destroy]

end
