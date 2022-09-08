Rails.application.routes.draw do
  root "projects#index"
  resource :projects, only: [:create, :destroy, :update]
  # post 'projects/create', to:"projects#create"
end
