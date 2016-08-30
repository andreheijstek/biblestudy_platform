require "rails_helper"

RSpec.feature "Users can view an overview of all studynotes" do
  scenario "sorted by ?" do
    studynote1 = FactoryGirl.create(:study_note, title: "title1")
    studynote2 = FactoryGirl.create(:study_note, title: "title2")
    visit study_notes_path

    save_and_open_page
    expect(page).to have_content "title1"
    expect(page).to have_content "title2"
  end
end
