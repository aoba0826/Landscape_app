Rails.application.routes.draw do
  root to: 'homes#top'

  get "search_tag" => "post_images#search_tag"
  get "task_calender" => "tasks#task_calender"

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follow_list
    end
  end

  resources :post_images,    only: [:new, :index, :show, :edit, :create, :destroy, :update] do
    resource :likes,         only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    get :search, on: :collection
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
  end
  resources :notifications, only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :tasks, only: [:edit, :index, :create, :update, :destroy]
  resources :schedule_days, only: [:create, :show, :destroy]
  resources :day_tasks, only: [:create, :destroy, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
