require 'rails_helper'

feature 'user cancels order' do
  scenario 'successfully' do
    order = create(:order)

    visit resume_order_path order
    within 'div#order_actions' do
      click_on 'Cancelar'
    end

    expect(page).to have_content 'Pedido cancelado com sucesso'
    within 'div#resume' do
      expect(page).to have_content order.product
      expect(page).to have_content order.plan
      expect(page).to have_content order.price
      expect(page).to have_content order.period
      expect(page).to have_css(:span, text: 'Cancelado')
    end
  end
end
