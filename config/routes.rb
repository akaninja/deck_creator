Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get 'search', to: 'cards#search'

  resources :cards
  resources :factions
  resources :card_types
end
