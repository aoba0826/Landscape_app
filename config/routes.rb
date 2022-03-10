Rails.application.routes.draw do
  root to:'homes#top'

  devise_for :users

  resources :users,          only:[:index,:show,:edit,:update]
  resources :post_images,    only:[:index,:show,:edit,:create,:destroy,:update]do
    resource :likes,         only:[:create,:destroy]
    resources :post_comments,only:[:create,:destroy]
  end
  resources :relationships,  only:[:index]
  resources :users do
    resource :relationships, only: [:create, :destroy]
  end
  resources :notifications,  only:[:index]
  resources :tasks,          only:[:index,:show,:edit,:create,:update,:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
