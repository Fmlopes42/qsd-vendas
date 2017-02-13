Rails.application.routes.draw do
  root 'vendas#index'

  resources :orders, only: [:show]
  put '/checkout/:order/coupon', to: 'vendas#apply_coupon', as: 'order_apply_coupon'
  get '/checkout/:order', to: 'vendas#checkout', as: 'order_checkout'
  get '/:product', to: 'vendas#product', as: 'product'
  get '/:product/:plan', to: 'vendas#plan', as: 'plan'
  get '/:product/:plan/:period/:price', to: 'orders#create', as: 'create_order'
  get '/order/resume/:order', to: 'vendas#resume_order', as: 'resume_order'
  get '/order/finish/:order', to: 'vendas#finish_order', as: 'finish_order'
end
