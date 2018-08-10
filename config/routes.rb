Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  resources :topics do
    resources :collections_memberships, only: [:create]
  end

  resources :collections
end
