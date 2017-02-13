class OrdersController < ApplicationController
  def create
    @order = Order.new order_params
    @order.save
    redirect_to order_checkout_path @order
  end

  def show
    @order = Order.find params[:id]
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
