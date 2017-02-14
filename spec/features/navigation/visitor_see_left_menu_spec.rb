require 'rails_helper'

feature 'visitor sees left menu' do
  scenario 'successfully' do
    visit root_path

    within 'nav.ls-menu' do
      expect(page).to have_link 'Início', root_path
      expect(page).to have_link 'Produtos', products_cart_path
    end
  end
end
