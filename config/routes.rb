Rails.application.routes.draw do
  resources :products, only: [:show], defaults: {format: :json}
end
