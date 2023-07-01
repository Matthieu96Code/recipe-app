Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login', sign_out: 'logout',
    password: 'secret', confirmation: 'verification',
    registration: 'register', edit: 'edit/profile'
  }, sign_out_via: [:get, :post]

  resources :foods
  resources :recipes do
    resources :recipe_foods
  end
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_recipe_public'
  put '/recipes/:id/add_to_shopping', to: 'recipes#add_to_shopping', as: 'add_to_shopping'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'foods#index'
end
