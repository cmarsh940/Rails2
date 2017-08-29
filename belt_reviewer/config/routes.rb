Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'
  
  resources :users
  get 'users/id' => 'user'
  resources :events
  resources :comments
  resources :sessions, only: [:create, :destroy]
end
