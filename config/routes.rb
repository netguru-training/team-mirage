Rails.application.routes.draw do
  resources :projects do
    resources :payments, only: [:new, :create]
    resources :comments, only: [:new, :create, :destroy]
    resources :ratings, only: [:new, :create]
  end

  root to: 'projects#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    resources :users
    get '/invitations/new' => 'invitations#new'
    post '/invitations' => 'invitations#create'
  end
end
