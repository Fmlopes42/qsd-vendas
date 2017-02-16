require 'rails_helper'

feature 'user indicates seller' do
  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    order = create(:order, user: user)
    seller = create(:user, name: 'seller', email: 'seller@example.com',
                           nickname: 'sel123', role: :seller)

    visit checkout_order_path order

    choose 'Boleto'

    fill_in 'Indicar vendedor', with: seller.nickname

    click_on 'Avançar'

    expect(page).to have_content "Vendedor #{seller.nickname}"
  end
end
