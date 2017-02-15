class Periodicity
  attr_reader :id, :name, :price
  PRICE_LIST = [
    { id: 1, name: 'Mensal', price: 15 },
    { id: 2, name: 'Trimestral', price: 40 },
    { id: 3, name: 'Semestral', price: 75 },
    { id: 4, name: 'Anual', price: 140 }
  ].freeze

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @price = params[:price]
  end

  def self.all
    PRICE_LIST.map do |price|
      new price
    end
  end

end
