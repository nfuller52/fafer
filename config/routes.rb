Rails.application.routes.draw do
  root to: "job_listings#index"

  get "/net-suite", to: "listings#net_suite"
  get "/sap", to: "listings#sap"
  get "/oracle", to: "listings#oracle"

  resources :publications, only: [:create]
  resources :job_listings, path: "/job-listings", only: [:new, :edit, :create, :update, :destroy], as: :job_listings
  resources :job_listings, path: "/", only: [:index, :show], as: :listings
end
