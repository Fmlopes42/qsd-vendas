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

  def apply_coupon
    @order = Order.find params[:order]
    coupon = Coupon.find params[:coupon]
    if coupon
      @order.apply_coupon coupon
      flash[:success] = 'Cupom aplicado com sucesso'
    else
      flash[:danger] = 'Cupom inválido'
    end
    redirect_to order_checkout_path @order
  end

  def resume_order
    @order = Order.find(params[:order])
  end
end
