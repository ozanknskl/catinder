Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#index'

  get 'about', to: 'home#about'
  resources :cats
  get 'new_cat', to: 'cats#new'
  get 'cats', to: 'cat#index'
  get 'mycats', to: 'home#mycats'
end
