require 'rails_helper'

feature 'user view plan options' do
  def set_product
    { name: 'Hospedagem', plans: %w(Básico Profissional Premium) }
  end
  scenario 'successfully' do
    product = set_product

    visit root_path

    click_on product[:name]

    within('section.product') do
      product[:plans].each do |plan|
        expect(page).to have_content plan
      end
    end
  end
end
