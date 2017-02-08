require 'rails_helper'

feature 'Visitor choices products' do
  scenario 'Sees all products' do
    products_lits = ['Hospedagem', 'Registro de Dominios', 'Email Marketing']

    visit root_path

    products_lits.each do |product|
      expect(page).to have_link product
    end
  end
end
