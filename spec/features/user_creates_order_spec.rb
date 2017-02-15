require 'rails_helper'

feature 'User creates order' do
  scenario 'when not logged in' do
    user = create(:user)
    order = build(:order)

    visit plan_prices_cart_path order.product, order.plan

    within 'div#Mensal' do
      click_on 'Contratar'
    end

    within('section#sign-in-form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha',  with: user.password

      click_on 'Entrar'
    end

    expect(page).to have_content order.product
    expect(page).to have_content order.plan
    expect(page).to have_content order.period
    expect(page).to have_content order.price
  end

  scenario 'when logged in' do
    user = create(:user)
    order = build(:order)

    visit new_user_session_path

    within('section#sign-in-form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha',  with: user.password

      click_on 'Entrar'
    end

    visit plan_prices_cart_path order.product, order.plan

    within 'div#Mensal' do
      click_on 'Contratar'
    end

    expect(page).to have_content order.product
    expect(page).to have_content order.plan
    expect(page).to have_content order.period
    expect(page).to have_content order.price
  end

  scenario 'check user IP' do
    user = create(:user)
    order = create(:order, source_ip: '175.100.10.1')
    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:ip).and_return('175.100.10.2')

    visit checkout_order_path(order)

    within('section#sign-in-form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha',  with: user.password

      click_on 'Entrar'
    end

    within('#flash-messages') do
      expect(page).to have_content 'Não foi possível concluir a operação.'
    end
  end
end
