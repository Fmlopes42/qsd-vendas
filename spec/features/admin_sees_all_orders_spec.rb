require 'rails_helper'

feature 'Admin sees all orders' do
  scenario 'successfully' do
    admin = create(:user, role: :admin)
    customer = create(:user)

    opened_order = create(:order, status: :opened, user: customer)
    closed_order = create(:order, status: :closed, user: customer)
    canceled_order = create(:order, status: :canceled, user: customer)

    login_as admin, scope: :user

    visit admin_orders_path

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
end
