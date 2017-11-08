# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can create new users' do
  let(:admin) { create(:user, :admin) }

  before do
    login_as(admin)
    visit '/'
    click_link 'Admin'
    click_link 'New User'
  end

  scenario 'with valid credentials' do
    fill_in t('activerecord.attributes.user.email'), with: 'newbie@example.com'
    fill_in t('activerecord.attributes.user.password'), with: 'password'

    submit_form

    should_see t('activerecord.messages.created')
  end

  scenario 'when the new user is an admin' do
    fill_in t('activerecord.attributes.user.email'), with: 'admin@example.com'
    fill_in t('activerecord.attributes.user.password'), with: 'password'
    check t('activerecord.attributes.user.is_admin')

    submit_form

    should_see t('activerecord.messages.created')
    should_see 'admin@example.com (Admin)'
  end
end
