Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  resources :topics
  resources :collections
  resources :collections_topics
end
