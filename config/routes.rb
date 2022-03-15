Rails.application.routes.draw do
  root to:'homes#top'
 
  devise_for :users

  resources :users,          only:[:index,:show,:edit,:update]do
    member do
      get :task_list
    end
  end
    
  resources :post_images,    only:[:new,:index,:show,:edit,:create,:destroy,:update,]do
    resource :likes,         only:[:create,:destroy]
    resources :post_comments,only:[:create,:destroy]
    get :search, on: :collection
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'follow' => 'relationships#follow'
  end
  resources :notifications,  only:[:index]
  resources :tasks,          only:[:show,:edit,:create,:update,:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
