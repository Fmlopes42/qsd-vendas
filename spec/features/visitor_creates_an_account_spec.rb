require 'rails_helper'

feature 'User creates an account' do
  scenario 'successfully' do
    user = build(:user)

    visit new_user_registration_path

    within('section#user-form') do
      fill_in 'Nome',                 with: user.name
      fill_in 'E-mail',               with: user.email
      fill_in 'Senha',                with: user.password, id: 'user_password'
      fill_in 'Confirmação de Senha', with: user.password_confirmation

      click_on 'Criar Conta'
    end

    within('section#flash-messages') do
      expect(page).to have_content(
        'Bem vindo! Você realizou seu registro com sucesso.'
      )
    end
  end

  scenario 'and should fill all fields' do
    visit new_user_registration_path

    within('section#user-form') { click_on 'Criar Conta' }

    within('section#user-form') do
      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('E-mail não pode ficar em branco')
      expect(page).to have_content('Senha não pode ficar em branco')
    end
  end
end
