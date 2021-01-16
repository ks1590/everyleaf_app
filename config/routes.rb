Rails.application.routes.draw do
  root "users#new"
  resources :tasks
  resources :users
end
