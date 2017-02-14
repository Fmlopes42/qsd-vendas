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

  private

  def order_params
    product = params[:product]
    plan = params[:plan]
    price = params[:price]
    period = params[:period]
    { product: product, plan: plan, price: price, period: period }
  end
end
