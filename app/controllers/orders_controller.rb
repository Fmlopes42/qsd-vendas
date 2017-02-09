class OrdersController < ApplicationController
  def create
    @order = Order.new order_params
    @order.save
    redirect_to root_path
  end

  private

  def order_params
    product = params[:prodct]
    plan = params[:plan]
    price = params[:price]
    period = params[:period]
    { product: product, plan: plan, price: price, period: period }
  end
end
