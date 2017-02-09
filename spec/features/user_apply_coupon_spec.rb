require 'rails_helper'

feature 'User apply coupon' do
  scenario 'successfuly' do
    coupon = Coupon.new key: 'cp001', type: 'fixed', value: 50

    order = create(:order)

    visit order_checkout_path(order.id)

    fill_in 'Insira seu cupom', with: coupon.key
    click_on 'Aplicar Cupom'
    within('strong#price') do
      expect(page).to have_content order.price.to_f - coupon.value
    end

    expect(page).to have_content 'Cupom aplicado com sucesso'
    expect(page).not_to have_css 'form#coupon_form'
  end
end
