Rails.application.routes.draw do
  resources :purchase_orders, :except => [:new, :edit]
  resources :stores, :except => [:new, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#main'
end
