ProbSet3::Application.routes.draw do
  resources :users
  resource :session

  match '/login' => "sessions#new", :as => "login"
  match '/logout' => "sessions#destroy", :as => "logout"
end
