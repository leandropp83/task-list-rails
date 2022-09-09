Rails.application.routes.draw do
  root "projects#index"
  resource :projects, only: [:create, :update, :destroy]
  get "projects/:id/destroy", to:"projects#destroy", as: :destroy
  # put "projects/:id", to:"projects#update", as: :update
end
