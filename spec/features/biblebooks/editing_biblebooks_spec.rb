require 'rails_helper'

RSpec.feature 'Users can edit existing biblebooks' do
  before do
    FactoryGirl.create(:biblebook, name: 'Voorbeeld bijbelboek')
    visit biblebooks_path

    click_link 'Voorbeeld bijbelboek'
    click_link t(:edit_bibilebook)
  end

  scenario 'with valid attributes' do
    fill_in t('simple_form.labels.biblebook.name'), with: 'Acts'

    submit_form

    expect(page).to have_content t(:biblebook_updated)
    expect(page).to have_content 'Acts'
  end

  scenario 'when providing invalid attributes' do
    fill_in t('simple_form.labels.biblebook.name'), with: ''
    submit_form
    expect(page).to have_content t(:biblebook_not_updated)
  end
end
