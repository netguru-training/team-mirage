Rails.application.routes.draw do
  resources :projects

  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  namespace :admin do
    resources :projects
    resources :users
  end
end
