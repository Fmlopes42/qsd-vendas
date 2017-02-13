require 'rails_helper'

feature 'User apply coupon' do
  before do
    user = create(:user)

    visit new_user_session_path

    within('section#sign-in-form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha',  with: user.password

      click_on 'Entrar'
    end
  end

  scenario 'successfuly' do
    coupon = Coupon.new key: 'cp001', type: 'fixed', value: 50

    order = create(:order, coupon: nil)

    visit order_checkout_path(order)

    fill_in 'Insira seu cupom', with: coupon.key
    click_on 'Aplicar Cupom'
    within('strong#price') do
      expect(page).to have_content order.price.to_f - coupon.value
    end

    expect(page).to have_content 'Cupom aplicado com sucesso'
    expect(page).not_to have_css 'form#coupon_form'
  end

  scenario 'apply invalid coupon' do
    order = create(:order, coupon: nil)
    visit order_checkout_path(order)

    fill_in 'Insira seu cupom', with: 'CupomInvalido'
    click_on 'Aplicar Cupom'

    within('strong#price') do
      expect(page).to have_content order.price
    end
    expect(page).to have_content 'Cupom inválido'
    expect(page).to have_css 'form#coupon_form'
  end

  scenario 'apply relative coupon successfully' do
    coupon = Coupon.new key: 'cpr001', type: 'percent', value: 10
    order = create(:order, coupon: nil)
    visit order_checkout_path(order)

    new_value = order.price.to_f * (1 - (coupon.value / 100.0))

    fill_in 'Insira seu cupom', with: coupon.key
    click_on 'Aplicar Cupom'

    within('strong#price') do
      expect(page).to have_content new_value
    end
    expect(page).to have_content 'Cupom aplicado com sucesso'
    expect(page).not_to have_css 'form#coupon_form'
  end
end
