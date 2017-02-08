Rails.application.routes.draw do
  root 'vendas#index'
  get '/:product', to: 'vendas#product', as: 'product'
  get '/:product/plan', to: 'vendas#plan', as: 'plan'
end
