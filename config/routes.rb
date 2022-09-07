Rails.application.routes.draw do
  get 'projects/index'
  get 'projects/create'
  get 'projects/destroy'
  get 'projects/update'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
