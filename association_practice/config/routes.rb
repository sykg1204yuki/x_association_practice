Rails.application.routes.draw do
  
  root 'tweets#index'
  
  devise_for :users
  
  resources :tweets do 
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, onl: [:create, :destroy]
    
  end 
  
  resources :users do 
    resources :relationships, only: [:create, :destroy]
    get 'follows', on: :member
    get 'followers', on: :member
    
  end 
  
end
