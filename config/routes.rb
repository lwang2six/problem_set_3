ProbSet3::Application.routes.draw do

  resources :seats

  root :to => "users#show"

  resources :users

  resources :chats do
    resources :messages
  end
  resource :session

  match '/login' => "sessions#new", :as => "login"
  match '/logout' => "sessions#destroy", :as => "logout"
end
