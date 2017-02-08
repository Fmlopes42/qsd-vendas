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
end
