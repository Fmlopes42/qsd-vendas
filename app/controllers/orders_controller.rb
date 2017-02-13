class OrdersController < ApplicationController
  def create
    if user_signed_in?
      @order = current_user.orders.new(order_params)
    else
      @order = Order.new order_params
    end
    @order.save
    redirect_to order_checkout_path @order
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
