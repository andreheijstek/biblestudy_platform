require "rails_helper"

RSpec.feature "Users can view an overview of all studynotes" do

  scenario "sorted by pericopes name" do

    b1 = FactoryGirl.create(:biblebook, name: "Jona", booksequence: 1)
    s1 = FactoryGirl.create(:studynote, title: "Jona", note: "Jona is bijzonder.")
    p1 = FactoryGirl.create(:pericope_by_name, name: 'Jona 1:1 - 1:10', biblebook_id: b1.id, studynote_id: s1.id)

    b2 = FactoryGirl.create(:biblebook, name: "Handelingen", booksequence: 1)
    s2 = FactoryGirl.create(:studynote, title: "Handelingen", note: "Handelingen ook.")
    p2 = FactoryGirl.create(:pericope_by_name, name: 'Handelingen 1:1 - 1:10', biblebook_id: b2.id, studynote_id: s2.id)

    visit pericopes_path

    expect(page).to have_content "Jona"
    expect(page).to have_content "Handelingen"

    expect("Jona").to appear_before("Handelingen")
  end

end
