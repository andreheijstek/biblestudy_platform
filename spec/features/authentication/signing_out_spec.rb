require 'rails_helper'

RSpec.feature 'Signed-in users can sign out' do

  let!(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
  end

  scenario do
    visit '/'

    click_link t(:sign_out)

    expect(page).to have_content t('devise.sessions.signed_out')
  end
end
