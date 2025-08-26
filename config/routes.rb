Rails.application.routes.draw do
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  get "follows/index"
  get "follows/create"
  get "follows/update"
  get "follows/destroy"
  get "likes/create"
  get "likes/destroy"
  get "comments/create"
  get "comments/destroy"
  get "posts/index"
  get "posts/show"
  get "posts/create"
  get "posts/edit"
  get "posts/update"
  get "posts/destroy"
  root "posts#index"

  devise_for :users

  resources :users, only: [:index, :show] do
    resource :profile, only: [:edit, :update, :show]
    resources :follows, only: [:create]           # send request
  end
  resources :follows, only: [:index, :update, :destroy] # manage requests (accept/decline/cancel)

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource  :like,     only: [:create, :destroy]
  end
end
