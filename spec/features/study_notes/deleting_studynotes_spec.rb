# frozen_string_literal: true

require 'rails_helper'

feature 'Users can delete studynotes' do
  let(:user)      { create(:user) }
  let(:otheruser) { create(:user) }

  let!(:s1) { create(:studynote, title: 'Jona', author: user) }

  scenario 'successfully' do
    login_as(user)
    visit studynotes_path

    click_link 'Jona'
    click_link t(:delete_item, item: Studynote.model_name.human)

    should_see t('activerecord.messages.deleted', model: 'bijbelstudie')
    expect(page.current_url).to eq pericopes_url
    expect(page).to have_no_content 'Jona'
  end

  scenario 'unless they do not have permission' do
    login_as(otheruser)
    visit studynotes_path

    click_link 'Jona'
    expect(page).not_to have_link t(:delete_item, item: Studynote.model_name.human)
  end
end
