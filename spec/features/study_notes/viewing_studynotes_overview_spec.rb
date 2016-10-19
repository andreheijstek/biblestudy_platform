require "rails_helper"

feature "Users can view an overview of all studynotes" do
  let(:user) { create(:user) }

  let!(:b1) { create(:biblebook, name: "Jona", booksequence: 34) }
  let!(:s1) { create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user) }
  let!(:p1) { create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id) }

  let!(:b2) { create(:biblebook, name: "Handelingen", booksequence: 53) }
  let!(:s2) { create(:studynote, title: "Handelingen", note: "Handelingen ook.", author: user) }
  let!(:p2) { create(:pericope_by_name, name: "Handelingen 1:1 - 1:10", biblebook_id: b2.id, studynote_id: s2.id) }

  scenario "sorted by pericopes name" do
    visit pericopes_path

    expect(page).to have_content "Jona"
    expect(page).to have_content "Handelingen"

    expect("Jona").to appear_before("Handelingen")

    click_link "Jona"
  end
end
