# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'

  root 'pericopes#index'

  namespace :admin do
    root 'application#index'
    resources :biblebooks do
      resources :chapters
    end
    resources :users
  end

  devise_for :users

  resources :studynotes
  resources :pericopes

  get 'profile', to: 'users#show'
end
