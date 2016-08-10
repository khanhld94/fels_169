Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root "static_pages#home"
  get "about" => "static_pages#about"
  namespace :admin do
    resources :categories
    resources :words, except: :show
    resources :users
  end 
  resources :users, only: [:index, :show] do
    resources :relationships, only: :index
    resources :activities, only: :index
  end
  resources :words, only: :index
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index, :show] do
    resources :lessons, except: [:edit, :destroy]
  end
end
