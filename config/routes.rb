Rails.application.routes.draw do
  resources :messages

  get "message/important", to: "messages#important_box", as: "message_important_box"
  get "message/sent", to: "messages#sent_box", as: "message_sent_box"
  get "message/archived", to: "messages#archived_box", as: "message_archived_box"

  post "message/mass_action", to: "messages#mass_action", as: "mass_action"
  get "message/important/:id", to: "messages#make_important", as: "message_make_important"

  devise_for :users
  root to: "messages#index"
end
