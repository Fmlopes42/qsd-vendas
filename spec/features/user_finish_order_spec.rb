require 'rails_helper'

feature 'User finish order' do
  scenario 'Successfuly' do
    user = create(:user)
    login_as user, scope: :user
    order = create(:order, user: user)

    visit resume_order_path order
    within 'div#order_actions' do
      click_on 'Finalizar Pedido'
    end

    expect(page).to have_content 'Pedido finalizado com sucesso'

    within 'div#resume' do
      expect(page).to have_content order.product
      expect(page).to have_content order.plan
      expect(page).to have_content order.price
      expect(page).to have_content order.period
      expect(page).to have_css(:span, text: 'Finalizado')
    end
  end
end
