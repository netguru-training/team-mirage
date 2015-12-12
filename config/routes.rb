Rails.application.routes.draw do
  resources :projects do
    resources :payments, only: [:new, :create]
  end

  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: :show

  namespace :admin do
    resources :projects
    resources :users
  end
end
