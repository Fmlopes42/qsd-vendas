require 'rails_helper'

feature 'User chooses payment' do
  scenario 'credit successfully' do
    user = create(:user)
    login_as user, scope: :user
    order = create(:order, user: user)
    visit checkout_order_path order
    message = 'Aguardando confirmação de pagamento pelo banco.'

    choose 'Crédito'

    fill_in 'Titular', with: 'Fernanda Monteiro Lopes'
    fill_in 'Número', with: '1234 1234 1234 1234'
    fill_in 'Validade', with: '12/20'
    fill_in 'CCV', with: '000'

    click_on 'Concluir'

    expect(page).to have_content message
  end

  scenario 'boleto successfully' do
    user = create(:user)
    login_as user, scope: :user
    order = create(:order, user: user)
    visit checkout_order_path order
    message = 'Boleto gerado, aguardando confirmação de pagamento pelo banco.'

    choose 'Boleto'

    click_on 'Concluir'

    expect(page).to have_content message
  end

  scenario 'and cannot submit empty form for credit card' do
    user = create(:user)
    login_as user, scope: :user
    order = create(:order, user: user)
    visit checkout_order_path order
    message = 'Não foi possível realizar seu pedido'

    choose 'Crédito'

    click_on 'Concluir'

    expect(page).to have_content message
  end
end
