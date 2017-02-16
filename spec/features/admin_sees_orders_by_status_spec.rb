require 'rails_helper'

feature 'Admin sees orders by status' do
  before do
    admin = create(:user, role: :admin)
    customer = create(:user)

    @opened_order = create(:order, status: :opened, user: customer)
    @closed_order = create(:order, status: :closed, user: customer)

    login_as admin, scope: :user

    visit root_path

    within('section#left-bar') { click_on 'Pedidos' }
  end

  scenario 'successfully' do
    within('section#orders-filter') { click_on 'Aberto' }

    within('section#orders') do
      expect(page).to have_content @opened_order.id
      expect(page).to have_content @opened_order.status
      expect(page).not_to have_content @closed_order.id
      expect(page).not_to have_content @closed_order.status
    end
  end

  scenario 'and sees a frinedly message if no orders have been found' do
    within('section#orders-filter') { click_on 'Cancelado' }

    within('section#flash-messages') do
      expect(page).to have_content 'Não foram encontrados pedidos'
    end

    within('section#orders') do
      expect(page).not_to have_content @opened_order.id
      expect(page).not_to have_content @opened_order.status
      expect(page).not_to have_content @closed_order.id
      expect(page).not_to have_content @closed_order.status
    end
  end
end
