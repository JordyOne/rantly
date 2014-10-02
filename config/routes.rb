Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :users do
    resources :rants
    member do  # what does this do, and why?
      get :followers, :following
    end
  end


  resources :sessions

end
