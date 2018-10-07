# frozen_string_literal: true

require 'rails_helper'

feature 'Users can edit existing studynotes', js: true do
  let(:user)      { create(:user) }
  let(:otheruser) { create(:user) }

  before do
    create(:studynote, title: 'Jona', note: 'Jona is bijzonder.', author: user)

    login_as(user)

    visit studynotes_path
    click_link 'Jona'
    click_link t(:edit_item, item: Studynote.model_name.human)
  end

  scenario 'with valid attributes' do
    new_text = 'Jona is heel bijzonder.'
    nsp = NewStudynotesPage.new
    nsp.studynote_field.set(new_text)
    nsp.submit_button.click

    should_see t(:item_updated, item: Studynote.model_name.human)
    should_see new_text
  end

  scenario 'except when providing invalid attributes' do
    nsp = NewStudynotesPage.new
    nsp.studynote_field.native.clear # enter an empty string into the field
    nsp.submit_button.click

    should_see t(:item_not_updated, item: Studynote.model_name.human)
  end

  scenario 'unless they do not have permission' do
    login_as(otheruser)
    visit studynotes_path

    click_link 'Jona'

    expect(page).not_to have_link t(:delete_item,
                                    item: Studynote.model_name.human)
  end
end
