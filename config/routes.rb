Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :items do
    resources :orders, only: [:index]
   end
  root to: "items#index"

end
