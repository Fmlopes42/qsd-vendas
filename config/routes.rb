Rails.application.routes.draw do
  devise_for :users
  root 'cart#products'
  
  namespace :admin do
    resources :orders, only: [:index]
  end

  resources :orders, only: [:show, :create] do
    member do
      put 'cancel'
      put 'finish'
      get 'resume'
      get 'checkout'
      put 'coupon'
    end
  end

  resource :cart, only: [] do
      get 'products', to: 'cart#products'
      get ':product/plans', to: 'cart#plans', as: 'product_plans'
      get ':product/:plan/prices', to: 'cart#prices', as: 'plan_prices'
      post ':product/:plan/:period/:price', to: 'orders#create', as: 'create_order'
  end

  resources :payments, only: [:create]



end
