Rails.application.routes.draw do
  resources :campers, only: %i[index show create]
  resources :activities, only: %i[index destroy]
  resources :signups, only: %i[create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
