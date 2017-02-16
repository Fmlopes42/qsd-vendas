class Product
  attr_reader :name, :id, :description

  PRODUCTS_LIST = [
    { name: 'Hospedagem', id: 1, description: 'Descrição' },
    { name: 'Registro de Dominios', id: 2, description: 'Descrição' },
    { name: 'Email Marketing', id: 3, description: 'Descrição' }
  ].freeze

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @description = params[:description]
  end

  def self.all
    PRODUCTS_LIST.map do |product|
      new product
    end
  end
end
