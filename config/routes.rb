Rails.application.routes.draw do
  devise_for :users

  resources :assets, path: "inventory" do
    resources :assignments, only: %i[create update], controller: "asset_assignments"
  end

  get "settings", to: "settings#index", as: :settings
  resources :categories, only: %i[create destroy]
  resources :statuses, only: %i[create destroy]

  root "assets#index"
end
