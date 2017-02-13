Rails.application.routes.draw do
  devise_for :users
  root 'vendas#index'

  put '/checkout/:order/coupon', to: 'vendas#apply_coupon', as: 'order_apply_coupon'
  get '/checkout/:order', to: 'vendas#checkout', as: 'order_checkout'
  get '/:product', to: 'vendas#product', as: 'product'
  get '/:product/:plan', to: 'vendas#plan', as: 'plan'
  get '/:product/:plan/:period/:price', to: 'orders#create', as: 'create_order'


end
