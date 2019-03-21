Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get 'search', to: 'cards#search'

  resources :cards do
    get 'my', on: :collection
    member do
      get 'highlight'
      delete 'unhighlight', to: 'cards#unhighlight'
      post 'add_to_deck'
      post 'send_email'
    end
  end
  
  resources :decks do
    get 'my', on: :collection
  end

  resources :factions
  resources :card_types
  resources :deck_cards

end
