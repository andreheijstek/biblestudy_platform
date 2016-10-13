Rails.application.routes.draw do
  root "pericopes#index"

  namespace :admin do
    root "application#index"
    resources :biblebooks do
      resources :chapters
    end
    resources :users
  end

  devise_for :users

  resources :studynotes
  resources :pericopes
end
