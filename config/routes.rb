Rails.application.routes.draw do
  root to: "projects#index"
  
  resources :projects
  
  resources :tickets
  
  resources :tags, only: [:index, :new, :edit, :create, :update, :destroy]
end
