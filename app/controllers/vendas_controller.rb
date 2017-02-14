class VendasController < ApplicationController
  PRODUCTS_LIST = [
    { name: 'Hospedagem', id: 1 },
    { name: 'Registro de Dominios', id: 2 },
    { name: 'Email Marketing', id: 3 }
  ].freeze
  PLANS_LIST = [
    { name: 'Básico', description: '', details: '' },
    { name: 'Profissional', description: '', details: '' },
    { name: 'Premium', description: '', details: '' }
  ].freeze

  PRICE_LIST = [
    { subscription: 'Mensal', price: 15 },
    { subscription: 'Trimestral', price: 40 },
    { subscription: 'Semestral', price: 75 },
    { subscription: 'Anual', price: 140 }
  ].freeze

  before_action :authenticate_user!, only: [:checkout]

  def index
    @products = PRODUCTS_LIST
  end

  def product
    @product = params[:product]
    @plans = PLANS_LIST
  end

  def plan
    @product = params[:product]
    @plan = params[:plan]
    @prices = PRICE_LIST
  end

  def checkout
    @order = Order.find(params[:order])
    unless @order.user_id?
      @order.user = current_user
      @order.save
    end
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
