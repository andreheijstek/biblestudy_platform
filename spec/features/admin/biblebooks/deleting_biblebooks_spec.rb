# frozen_string_literal: true

require 'rails_helper'

feature 'Users can delete biblebooks' do
  before do
    login_as(create(:user, :admin))
  end

  scenario 'successfully' do
    create(:biblebook, name: 'Handelingen')
    visit admin_biblebooks_path
    click_link 'Handelingen'

    click_link t(:delete_item, item: Biblebook.model_name.human)

    should_see t(:biblebook_deleted)
    expect(page.current_url).to eq admin_biblebooks_url
    expect(page).to have_no_content 'Handelingen'
  end
end
