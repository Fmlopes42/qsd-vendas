require 'rails_helper'

feature 'user sees left menu' do
  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user

    visit root_path

    within 'nav.ls-menu' do
      expect(page).to have_link 'Início', href: root_path
      expect(page).to have_link 'Produtos', href: root_path
    end
  end
end
