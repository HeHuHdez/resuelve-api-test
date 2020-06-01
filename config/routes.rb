Rails.application.routes.draw do
  namespace :api do
    resources :payments, only: :create
  end
end
