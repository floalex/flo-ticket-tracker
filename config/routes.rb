Rails.application.routes.draw do
  root to: "projects#index"
  
  get '/signup', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  
  resources :projects
  
  resources :tickets do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
  resources :tags, only: [:index, :new, :edit, :create, :update, :destroy]
  
  resources :users, only: [:index, :create] 
end
