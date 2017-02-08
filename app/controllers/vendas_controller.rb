class VendasController < ApplicationController
  PRODUCTS_LIST = [
    { name: 'Hospedagem', id: 1 },
    { name: 'Registro de Dominios', id: 2 },
    { name: 'Email Marketing', id: 3 }
  ].freeze

  def index
    @products = PRODUCTS_LIST
  end
end
