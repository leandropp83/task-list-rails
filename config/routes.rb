Rails.application.routes.draw do
  root "projects#index"
  resource :projects, only: [:create, :destroy, :update]
end
