Rails.application.routes.draw do
  root 'welcome#index'

  resources :users do
    resources :relationships, only: [:create, :destroy]
    resources :rants
    member do  # gives custom routes
      get :followers, :following
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

end
