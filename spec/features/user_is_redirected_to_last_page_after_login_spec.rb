require 'rails_helper'

feature 'User is redirected to last page after login' do
  scenario 'successfully' do
    user = create(:user)

    visit plan_prices_cart_path('Hospedagem', 'Premium')

    within('section#navbar') { click_on 'Entrar' }

    within('section#sign-in-form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha',  with: user.password

      click_on 'Entrar'
    end

    expect(current_path).to eq plan_prices_cart_path('Hospedagem', 'Premium')
  end
end
