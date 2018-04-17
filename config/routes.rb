Rails.application.routes.draw do
  root to: "job_listings#index"

  resources :job_listings, path: "/job-listings", only: [:new, :edit, :create, :update, :destroy], as: :job_listings
  resources :job_listings, path: "/", only: [:index, :show], as: :listings
  resources :platforms, only: [:show]
  resources :publications, only: [:create]
end
