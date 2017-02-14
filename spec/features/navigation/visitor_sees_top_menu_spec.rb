require 'rails_helper'

feature 'visitor sees top menu' do
  scenario 'successfully' do
    visit root_path

    within 'div.ls-topbar' do
      expect(page).to have_link 'Entrar', new_user_session_path
      expect(page).to have_link 'Cadastrar', new_user_registration_path
      expect(page).to have_css 'span.ls-name', text: 'Acessar Conta'
    end
  end
end
