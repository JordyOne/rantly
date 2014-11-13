Rails.application.routes.draw do
  root 'welcome#index'

  resources :users do
    resources :relationships, only: [:create, :destroy]
    resources :rants, only: [:create, :destroy, :show]
    resources :profiles, only: [:show] do
      resources :rants, only: [:show]
    end
    resources :favorites, only: [:create, :destroy]
    member do
      get :followers, :following
    end
  end


  resources :searches, only: [:show, :index]

  resources :dashboards, only: [:show]

  resources :sessions, only: [:new, :create, :destroy]

end
