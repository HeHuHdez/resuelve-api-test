Rails.application.routes.draw do
  namespace :api do
    resources :payments, only: [:create, :index]
    root to: "payments#index"
  end
end
