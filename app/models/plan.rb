class Plan
  attr_reader :id, :name, :description, :details

  PLANS_LIST = [
    { name: 'Básico', description: 'descrição', details: 'detalhes' },
    { name: 'Profissional', description: 'descrição', details: 'detalhes' },
    { name: 'Premium', description: 'descrição', details: 'detalhes' }
  ].freeze

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @description = params[:description]
    @details = params[:details]
  end

  def self.all
    PLANS_LIST.map do |plan|
      new plan
    end
  end
end
