Rails.application.routes.draw do

  resources :listings
  resources :listings, only: [:show] do
    resources :reservations, only: [:new, :create]
  end
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :reservations, only: [:show] do
    resources :transactions, only: [:new, :create]
  end

  resources :reservations, only: [:index]
 
  resources :users, only: [:show, :edit, :update]
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get 'welcome/index'

  get "/auth/:provider/callback",to: "sessions#create_from_omniauth"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'
   post "/", to: "listings#index"

end
