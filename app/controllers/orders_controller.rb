class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]
  def create
    if user_signed_in?
      @order = current_user.orders.new(order_params)
    else
      @order = Order.new order_params
    end
    @order.save
    redirect_to checkout_order_path @order
  end

  def coupon
    @order = Order.find params[:id]
    coupon = Coupon.find params[:coupon]

    if coupon
      @order.apply_coupon coupon
      flash[:success] = 'Cupom aplicado com sucesso'
    else
      flash[:danger] = 'Cupom inválido'
    end

    redirect_to checkout_order_path @order
  end

  def show
    @order = Order.find params[:id]
  end

  def cancel
    @order = Order.find params[:id]
    @order.status = 'canceled'
    @order.save
    flash[:danger] = 'Pedido cancelado com sucesso'
    redirect_to @order
  end

  def finish
    @order = Order.find params[:id]
    @order.status = 'closed'
    @order.save
    flash[:success] = 'Pedido finalizado com sucesso'
    redirect_to @order
  end

  def resume
    @order = Order.find params[:id]
  end

  def checkout
    @order = Order.find params[:id]
    @credit = Credit.new
    @payment = Payment.new
  end

  private

  def order_params
    product = params[:product]
    plan = params[:plan]
    price = params[:price]
    period = params[:period]
    { product: product, plan: plan, price: price, period: period }
  end
end
