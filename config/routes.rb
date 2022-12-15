# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  
  resources :posts do
    post :create_member, to: 'posts#create_member', on: :member
    resources :comments, module: :posts, only: %i[create edit destroy]
  end
end
