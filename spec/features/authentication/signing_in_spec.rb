require 'rails_helper'

feature 'Users can sign in' do
  let!(:user) { create(:user) }

  scenario 'with valid credentials' do
    ensure_on '/'
    click_link t(:sign_in)

    fill_in t('activerecord.attributes.user.email'), with: user.email
    fill_in t('activerecord.attributes.user.password'), with: 'password'
    click_button t(:sign_in)

    should_see t('devise.sessions.signed_in')
    should_see "#{t('signed_in_as')} #{user.email}"
  end
end
