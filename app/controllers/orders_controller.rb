class OrdersController < ApplicationController
  before_action :set_menus, only: [:show, :checkout, :resume]
  before_action :authenticate_user!, except: [:create]

  def create
    @order = Order.new(order_params)
    current_user.orders << @order if user_signed_in?
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
    @order.canceled!
    flash[:danger] = 'Pedido cancelado com sucesso'
    redirect_to @order
  end

  def finish
    @order = Order.find params[:id]
    @order.closed!
    flash[:success] = 'Pedido finalizado com sucesso'
    redirect_to @order
  end

  def resume
    @order = Order.find params[:id]
  end

  def checkout
    @order = Order.find params[:id]
    unless @order.user
      if @order.source_ip == request.remote_ip
        @order.user = current_user
        @order.save
      else
        flash[:danger] = 'Não foi possível concluir a operação.'
        redirect_to root_path
      end
    end
  end

  private

  def order_params
    { product: params[:product], plan: params[:plan], price: params[:price],
      period: params[:period], source_ip: request.remote_ip }
  end
end
