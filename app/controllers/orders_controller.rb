class OrdersController < ApplicationController
  before_action :set_menus, only: [:show, :checkout, :resume]
  before_action :authenticate_user!, except: [:create, :checkout]
  before_action :authenticate_user_to_order!, except: [:create, :checkout]

  def create
    @order = Order.new(order_params)
    current_user.orders << @order if user_signed_in?
    @order.save
    redirect_to checkout_order_path @order
  end

  def coupon
    coupon = Coupon.find params[:coupon]

    if coupon
      @order.apply_coupon coupon
      flash[:success] = 'Cupom aplicado com sucesso'
    else
      flash[:danger] = 'Cupom inválido'
    end

    redirect_to checkout_order_path @order
  end

  def show; end

  def cancel
    @order.canceled!
    flash[:danger] = 'Pedido cancelado com sucesso'
    redirect_to @order
  end

  def finish
    @order.closed!
    flash[:success] = 'Pedido finalizado com sucesso'
    redirect_to @order
  end

  def resume; end

  def checkout
    @order = Order.find params[:id]
    authenticate_user_to_checkout
    unless @order.check_integrity?(request.remote_ip, current_user)
      flash[:danger] = 'Não foi possível concluir a operação.'
      redirect_to root_path
    end
    @credit = Credit.new
    @payment = Payment.new
  end

  private

  def order_params
    { product: params[:product], plan: params[:plan], price: params[:price],
      period: params[:period], source_ip: request.remote_ip }
  end

  def authenticate_user_to_order!
    @order = Order.find params[:id]
    return if @order.valid_user?(current_user)
    flash[:danger] = 'Não foi possível concluir a operação.'
    redirect_to root_path
  end

  def authenticate_user_to_checkout
    return if user_signed_in?
    flash[:info] = 'Para continuar o checkout do pedido' \
      "#{@order.id} faça login ou registre-se"
    redirect_to new_user_session_path
  end
end
