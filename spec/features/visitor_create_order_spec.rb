require 'rails_helper'

feature 'Visitor create order spec' do
  scenario 'successfully' do
    pending
    order = build(:order)

    visit '/hospedagem/premium'

    click_on 'Mensal'

    expect(page).to have_content order.product
    expect(page).to have_content order.plan
    expect(page).to have_content order.perion
    expect(page).to have_content order.price
    expect(page).to have_content order.coupon
    expect(page).to have_link 'Concluir pedido'
  end
end
