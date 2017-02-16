require 'rails_helper'

feature 'User apply coupon' do
  before do
    @user = create(:user)
    login_as @user, scope: :user
  end

  scenario 'successfuly' do
    coupon = Coupon.new key: 'cp001', type: 'fixed', value: 50

    order = create(:order, coupon: nil, user: @user, price: 60)

    visit checkout_order_path(order)

    fill_in 'Insira seu cupom', with: coupon.key
    click_on 'Aplicar Cupom'
    within('strong#price') do
      expect(page).to have_content order.price - coupon.value
    end

    expect(page).to have_content 'Cupom aplicado com sucesso'
    expect(page).not_to have_css 'form#coupon_form'
  end

  scenario 'apply invalid coupon' do
    order = create(:order, coupon: nil, user: @user)
    visit checkout_order_path(order)

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
    order = create(:order, coupon: nil, user: @user)
    visit checkout_order_path(order)

    new_value = order.price * (1 - (coupon.value / 100.0))

    fill_in 'Insira seu cupom', with: coupon.key
    click_on 'Aplicar Cupom'

    within('strong#price') do
      expect(page).to have_content new_value
    end
    expect(page).to have_content 'Cupom aplicado com sucesso'
    expect(page).not_to have_css 'form#coupon_form'
  end

  scenario 'coupon discount is bigger than product value' do
    coupon = Coupon.new key: 'cp001', type: 'fixed', value: 50

    order = create(:order, coupon: nil, user: @user, price: 30)

    visit checkout_order_path(order)

    fill_in 'Insira seu cupom', with: coupon.key
    click_on 'Aplicar Cupom'
    within('strong#price') do
      expect(page).to have_content '0.0'
    end

    expect(page).to have_content 'Cupom aplicado com sucesso'
    expect(page).not_to have_css 'form#coupon_form'
  end
end
