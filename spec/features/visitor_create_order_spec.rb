require 'rails_helper'

feature 'Visitor create order spec' do
  scenario 'successfully' do
    order = build(:order)

    visit plan_path order.product, order.plan

    click_on 'Mensal'

    expect(page).to have_content order.product
    expect(page).to have_content order.plan
#    expect(page).to have_content order.period
    expect(page).to have_content order.price
  end
end
