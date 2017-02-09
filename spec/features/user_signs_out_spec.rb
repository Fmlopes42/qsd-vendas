require 'rails_helper'

feature 'User signs out' do
  scenario 'successfully' do
    user = create(:user)

    visit new_user_session_path

    within('section#sign-in-form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha',  with: user.password

      click_on 'Entrar'
    end

    within('section#navbar') { click_on 'Sair' }

    within('section#flash-messages') do
      expect(page).to have_content 'Logout efetuado com sucesso.'
    end
  end
end
