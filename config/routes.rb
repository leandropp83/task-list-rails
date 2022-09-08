Rails.application.routes.draw do
  root "projects#index"
  resource :projects, only: [:create, :update]
  delete "projects/:id", to:"projects#destroy", as: :destroy
end
