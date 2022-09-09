Rails.application.routes.draw do
  root "projects#index"
  resource :projects, only: [:create, :update, :destroy]
  resource :tasks, only: [:create, :update]
  get "projects/:id/destroy", to:"projects#destroy", as: :destroy
end
