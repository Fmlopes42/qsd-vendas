require 'rails_helper'

feature 'User finish order' do
  scenario 'Successfuly' do
    user = create(:user)
    login_as user, scope: :user
    order = create(:order, user: user)
    payment = create(:payment, order: order)
    create(:credit, payment: payment)

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

  scenario 'cant alter an order that is not opened' do
    order = create(:order, status: 'closed')

    visit resume_order_path order
    expect(page).to_not have_current_path resume_order_path order
  end
end
