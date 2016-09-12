=begin
require "rails_helper"

RSpec.feature "Users can view an overview of all studynotes" do
  let (:studynote1) { FactoryGirl.create(:study_note, title: "title1", pericoop: 'Handelingen 1:2 - 3:4') }
  let (:studynote2) { FactoryGirl.create(:study_note, title: "title2", pericoop: 'Exodus 1:2 - 3:4') }

  scenario "sorted by pericopes name" do
    studynote1 = FactoryGirl.create(:study_note, title: "title1")
    studynote2 = FactoryGirl.create(:study_note, title: "title2")
    visit pericopes_path

    expect(page).to have_content "title1"
    expect(page).to have_content "title2"

    expect("title2").to appear_before("title1")
  end

end
=end
