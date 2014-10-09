Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  #you are about to create a follow button that refers to the users controller and uses the private methods of user class.

  resources :users do
    resources :rants
    member do  # what does this do, and why?
      get :followers, :following
    end
  end


  resources :sessions

end
