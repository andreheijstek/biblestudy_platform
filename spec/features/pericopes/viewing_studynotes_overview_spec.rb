require "rails_helper"

RSpec.feature "Users can view an overview of all studynotes" do

  scenario "sorted by pericopes name 1" do
    b2 = FactoryGirl.create(:biblebook, name: "Handelingen", booksequence: 53)
    s2 = FactoryGirl.create(:studynote, title: "Handelingen", note: "Handelingen ook.")
    p2 = FactoryGirl.create(:pericope_by_name, name: 'Handelingen 1:1 - 1:10', biblebook_id: b2.id, studynote_id: s2.id)

    b1 = FactoryGirl.create(:biblebook, name: "Jona", booksequence: 34)
    s1 = FactoryGirl.create(:studynote, title: "Jona", note: "Jona is bijzonder.")
    p1 = FactoryGirl.create(:pericope_by_name, name: 'Jona 1:1 - 1:10', biblebook_id: b1.id, studynote_id: s1.id)

    visit pericopes_path

    expect(page).to have_content "Jona"
    expect(page).to have_content "Handelingen"

    expect("Jona").to appear_before("Handelingen")
  end

  scenario "sorted by pericopes name 2" do
    b2 = FactoryGirl.create(:biblebook, name: "Micha", booksequence: 35)
    s2 = FactoryGirl.create(:studynote, title: "Micha", note: "Het Micha project")
    p2 = FactoryGirl.create(:pericope_by_name, name: 'Micha 3:6-7', biblebook_id: b2.id, studynote_id: s2.id)

    b1 = FactoryGirl.create(:biblebook, name: "Jona", booksequence: 34)
    s1 = FactoryGirl.create(:studynote, title: "Jona", note: "Jona is bijzonder.")
    p1 = FactoryGirl.create(:pericope_by_name, name: 'Jona 1:1 - 1:10', biblebook_id: b1.id, studynote_id: s1.id)

    visit pericopes_path

    expect(page).to have_content "Jona"
    expect(page).to have_content "Micha"

    expect("Jona").to appear_before("Micha")
  end

end
