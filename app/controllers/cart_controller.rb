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
