Rails.application.routes.draw do
  get 'users/me', to: 'users#me'
  jsonapi_resources :users
  jsonapi_resources :courses
  jsonapi_resources :holes
  jsonapi_resources :rounds
  jsonapi_resources :scores
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
