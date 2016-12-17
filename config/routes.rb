Rails.application.routes.draw do
  resources :scores
  resources :rounds
  resources :holes
  resources :courses
  resources :users
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
