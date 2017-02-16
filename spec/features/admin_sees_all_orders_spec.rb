require 'rails_helper'

feature 'Admin sees all orders' do
  before do
    admin = create(:user, role: :admin)
    @customer = create(:user)
    login_as admin, scope: :user
    visit root_path
  end

  scenario 'successfully' do
    opened_order = create(:order, status: :opened, user: @customer)
    closed_order = create(:order, status: :closed, user: @customer)
    canceled_order = create(:order, status: :canceled, user: @customer)

    within('section#left-bar') { click_on 'Pedidos' }

    within('section#orders') do
      expect(page).to have_content opened_order.id
      expect(page).to have_content opened_order.status
      expect(page).to have_content closed_order.id
      expect(page).to have_content closed_order.status
      expect(page).to have_content canceled_order.id
      expect(page).to have_content canceled_order.status

      expect(page).to have_content opened_order.product
      expect(page).to have_content opened_order.plan
      expect(page).to have_content opened_order.period
      expect(page).to have_content opened_order.price
      expect(page).to have_content opened_order.user.name
    end
  end

  scenario 'and sees a frinedly message if no orders have been found' do
    within('section#left-bar') { click_on 'Pedidos' }

    within('section#flash-messages') do
      expect(page).to have_content 'Não foram encontrados pedidos'
    end
  end
end
