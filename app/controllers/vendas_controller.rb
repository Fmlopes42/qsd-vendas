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

  def index
    @products = PRODUCTS_LIST
  end

  def product
    @product = params[:product]
    @plans = PLANS_LIST
  end
end
