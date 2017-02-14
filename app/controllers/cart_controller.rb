class CartController < ApplicationController
  before_action :set_menus

  PRICE_LIST = [
    { subscription: 'Mensal', price: 15 },
    { subscription: 'Trimestral', price: 40 },
    { subscription: 'Semestral', price: 75 },
    { subscription: 'Anual', price: 140 }
  ].freeze

  def plans
    @product = params[:product]
    @plans = Plan.all
  end

  def prices
    @product = params[:product]
    @plan = params[:plan]
    @prices = PRICE_LIST
  end

  def products
    @products = Product.all
  end
end
