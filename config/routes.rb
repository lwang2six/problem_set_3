ProbSet3::Application.routes.draw do
  root :to => "users#show"

  resources :users
  resource :session

  match '/login' => "sessions#new", :as => "login"
  match '/logout' => "sessions#destroy", :as => "logout"
end
