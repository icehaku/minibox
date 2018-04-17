Rails.application.routes.draw do
  resources :messages
  post "message/mass_action", to: "messages#mass_action", as: "mass_action"

  devise_for :users
  root to: "messages#index"
end
