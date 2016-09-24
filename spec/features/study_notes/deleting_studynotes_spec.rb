require 'rails_helper'

RSpec.feature 'Users can delete studynotes' do
  scenario 'successfully' do
    b1 = create(:biblebook, name: 'Jona')
    s1 = create(:studynote, title: 'Jona', note: 'Jona is bijzonder.')
    FactoryGirl.create(:pericope_by_name, name: 'Jona 1:1 - 1:10', biblebook_id: b1.id, studynote_id: s1.id)
    visit studynotes_path

    click_link 'Jona'
    click_link t(:delete_studynote)

    expect(page).to have_content t(:studynote_deleted)
    expect(page.current_url).to eq studynotes_url
    expect(page).to have_no_content 'Jona'
  end
end
