require 'rails_helper'

feature 'User creates order' do
  scenario 'when not logged in' do
    user = create(:user)
    order = build(:order)

    visit plan_path order.product, order.plan

    click_on 'Mensal'

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

    visit plan_path order.product, order.plan

    click_on 'Mensal'

    expect(page).to have_content order.product
    expect(page).to have_content order.plan
    expect(page).to have_content order.period
    expect(page).to have_content order.price
  end
end
