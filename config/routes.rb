Rails.application.routes.draw do
  root to: "projects#index"
  
  resources :projects
  
  resources :tickets
  
  resources :tags, only: [:create, :update, :destroy]
end
