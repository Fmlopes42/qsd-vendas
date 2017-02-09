Rails.application.routes.draw do
  devise_for :users
  root 'vendas#index'

  get '/:product', to: 'vendas#product', as: 'product'
  get '/:product/:plan', to: 'vendas#plan', as: 'plan'


end
