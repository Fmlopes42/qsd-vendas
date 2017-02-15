require 'rails_helper'

feature 'user cancels order' do
  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    order = create(:order, user: user)
    payment = create(:payment, order: order)
    create(:credit, payment: payment)

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

  scenario 'only if he/she is the order owner' do
    another_user = create(:user)
    order = create(:order, user: another_user)

    user = create(:user)
    login_as user, scope: :user

    visit resume_order_path order

    within('section#flash-messages') do
      expect(page).to have_content 'Não foi possível concluir a operação.'
    end
  end
end
