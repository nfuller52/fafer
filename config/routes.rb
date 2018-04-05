Rails.application.routes.draw do
  root to: "listings#index"

  resources :listings, path: "/", only: [:index, :show]
  resources :job_listings, path: "/job-listings", only: [:new, :edit, :create, :update, :destroy]
end
