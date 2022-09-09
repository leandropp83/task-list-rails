Rails.application.routes.draw do
  root "projects#index"
  resource :projects, only: [:create, :update, :destroy]
  resource :tasks, only: [:create, :update, :destroy]
  get "projects/:id/destroy", to:"projects#destroy", as: :destroy_projects
  get "tasks/:id/destroy", to:"tasks#destroy", as: :destroy_tasks
  post "tasks/:id/check", to:"tasks#update", method: :update
end
