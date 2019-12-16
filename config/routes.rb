Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  mount Ckeditor::Engine => '/ckeditor'
  ActiveAdmin.routes(self)
  devise_for :users
  root "courses#index"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  resources :users, only: [:edit, :update, :show]
  resources :feedbacks
  resources :conversations, only: [:index, :create] do
    member do
      post :close
    end
  end
  resources :courses, only: [:index, :show]
  resources :subjects, only: [:show]
  resources :enrollments, :show
  resources :enrollments do
    get "/attempt", to: "test_attempts#attempt"
    post "/get_result", to: "test_attempts#get_result"
  end
end
