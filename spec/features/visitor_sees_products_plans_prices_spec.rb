require 'rails_helper'

feature 'Visitor sees products/plans prices' do
  scenario 'successfully' do
    price_list = { mensal: 15, trimestral: 40, semestral: 75, anual: 140 }

    visit plan_prices_cart_path('Hospedagem', 'Premium')

    price_list.each do |subscription, price|
      expect(page).to have_link subscription.to_s.camelcase
      expect(page).to have_link price.to_s
    end

    expect(page).to have_css('h3', text: 'Hospedagem / Premium')
  end
end