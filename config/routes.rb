Rails.application.routes.draw do
  root to: "projects#index"
  
  get '/signup', to: 'users#new'
  
  resources :projects
  
  resources :tickets
  
  resources :tags, only: [:index, :new, :edit, :create, :update, :destroy]
  
  resources :users, only: [:create] 
end
