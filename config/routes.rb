Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root "static_pages#home"
  get "about" => "static_pages#about"
  namespace :admin do
    resources :categories, only: [:new, :create]
  end 
  resources :users, only: [:index, :show] do
    resources :relationships, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]
end
