class CartController < ApplicationController
  before_action :set_menus

  def plans
    @product = params[:product]
    @plans = Plan.all
  end

  def prices
    @product = params[:product]
    @plan = params[:plan]
    @periodicity = Periodicity.all
  end

  def products
    @products = Product.all
  end
end
