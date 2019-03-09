Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get 'search', to: 'cards#search'

  resources :cards do
    get 'my', on: :collection
    member do
      get 'highlight'
      delete 'unhighlight', to: 'cards#unhighlight'
    end
  end

  resources :factions
  resources :card_types

end
