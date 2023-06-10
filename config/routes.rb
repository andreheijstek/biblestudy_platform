# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  get "users/index"

  root "pericopes#index"

  namespace :admin do
    root "application#index"
    resources :biblebooks do
      resources :chapters, except: [:index]
    end
    resources :users, except: [:destroy]
  end

  devise_for :users

  resources :studynotes
  resources :pericopes, except: %i[create update]

  get "profile", to: "users#show"
end
