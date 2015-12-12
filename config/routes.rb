Rails.application.routes.draw do
  resources :projects

  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: :show

  namespace :admin do
    resources :projects
    resources :users
  end
end
