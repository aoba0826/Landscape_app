Rails.application.routes.draw do

  root to:"posts#index"
  devise_for :users
  
  resources :users,          only:[:index,:show,:edit,:update]
  resources :post_images,    only:[:index,:show,:edit,:create,:destroy,:update]do
    resource :likes,         only:[:create,:destroy]
    resources :post_comments,only:[:create,:destroy]
  end
  resource  :relationships,  only:[:create, :destroy]
  resources :relationships,  only:[:index,:show]
  resources :tasks,          only:[:index,:show,:edit,:create,:update,:destroy]        
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
