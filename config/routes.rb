Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#index'

  get 'about', to: 'home#about'
  resources :cats do
    member do
      get 'like'
    end
  end

  resources :cats do
    member do
      get 'dislike'
    end
  end

  resources :messages, only: [:create, :new] do 
    get 'availableusers'
  end
  resources :conversations, only: [:index,:show]

  get 'profile' , to: 'home#profile'
  get 'new_cat', to: 'cats#new'
  get 'cats', to: 'cat#index'
  get 'mycats', to: 'home#mycats'
  get 'search', to: 'cats#search'
  get 'csearch', to: 'cats#custom_search'
  get 'conversations', to: 'conversations#index'
end
