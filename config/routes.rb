Rails.application.routes.draw do
  get "/" to: "application#cookie" as: :root
  resources :goals
  post "/signup", to: "users#create"
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :breakdowns
  resources :mods
  resources :phases
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
