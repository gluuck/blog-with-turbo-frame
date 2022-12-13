# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
    resources :comments, only: %i[create edit destroy]
  end
end
