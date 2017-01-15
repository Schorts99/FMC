require "sidekiq/web"

Rails.application.routes.draw do

  get '/reglamento', to: "reglamento#index"
  get '/facultad', to: "reglamento#facultad"

  resources :notifications, only: [:index, :update]
  resources :posts
  resources :estudiantes, as: :students, only: [:show, :update]
  resources :friendships, only: [:create, :update, :index, :destroy]

  devise_for :students

  authenticated :student do
  	root 'main#home'
  end

  unauthenticated :student do
  	root 'main#unregistered'
  end

  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
