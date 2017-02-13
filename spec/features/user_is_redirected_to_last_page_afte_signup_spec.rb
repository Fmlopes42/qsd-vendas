require 'rails_helper'

feature 'User is redirected to last page after sign up' do
  scenario 'successfully' do
    user = build(:user)

    visit plan_path('Hospedagem', 'Premium')

    within('section#navbar') { click_on 'Cadastrar' }

    within('section#user-form') do
      fill_in 'Nome',                 with: user.name
      fill_in 'E-mail',               with: user.email
      fill_in 'Senha',                with: user.password, id: 'user_password'
      fill_in 'Confirmação de Senha', with: user.password_confirmation

      click_on 'Criar Conta'
    end

    expect(current_path).to eq plan_path('Hospedagem', 'Premium')
  end
end
