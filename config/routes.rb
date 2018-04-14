Rails.application.routes.draw do
  resources :messages
  devise_for :users
  root to: "home#index"
end
