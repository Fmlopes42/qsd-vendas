require 'rails_helper'

feature 'user sees top menu' do
  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    within 'div.ls-topbar' do
      expect(page).to have_link 'Meus dados', href: root_path
      expect(page).to have_css 'span.ls-name', text: user.name
      expect(page).to have_link(I18n.t('nav.sign_out'),
                                href: destroy_user_session_path)
    end
  end
end
