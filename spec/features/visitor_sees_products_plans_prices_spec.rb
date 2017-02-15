require 'rails_helper'

feature 'Visitor sees products/plans prices' do
  scenario 'successfully' do

    product = Product.all.first

    plan = Plan.all.first

    periodicities_list = Periodicity.all

    visit plan_prices_cart_path(product.name, plan.name)

    periodicities_list.each do |periodicity|
      expect(page).to have_link periodicity.name
      expect(page).to have_content periodicity.price
    end
  end
end
