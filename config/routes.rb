Rails.application.routes.draw do
  root to: "listings#index"

  get "/net-suite", to: "listings#net_suite"
  get "/sap", to: "listings#sap"
  get "/oracle", to: "listings#oracle"

  resources :listings, path: "/", only: [:index, :show]
  resources :job_listings, path: "/job-listings", only: [:new, :edit, :create, :update, :destroy] do
    member do
      put "publish"
    end
  end
end
