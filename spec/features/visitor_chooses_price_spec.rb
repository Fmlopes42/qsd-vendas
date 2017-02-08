require 'rails_helper'

feature 'Visitor chooses a price' do
  scenario 'successfully' do
    price_list = { mensal: 15, trimestral: 40, semestral: 75, anual: 140 }

    visit plan_path('Hospedagem', 'Premium')

    price_list.each do |subscription, price|
      expect(page).to have_link subscription.to_s.camelcase
      expect(page).to have_link price.to_s
    end

    expect(page).to have_css('h3', 'Hospedagem / Premium')
  end
end
