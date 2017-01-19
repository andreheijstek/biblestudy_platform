require "rails_helper"

feature "Users can view an overview of all studynotes" do
  let(:user) { create(:user) }
  let!(:b1) { create(:biblebook, name: "Jona", testament: "oud", booksequence: 34) }
  let!(:b2) { create(:biblebook, name: "Maleachi", testament: "oud", booksequence: 45) }
  let!(:b3) { create(:biblebook, name: "Mattheus", testament: "nieuw", booksequence: 51) }
  let!(:b4) { create(:biblebook, name: "Openbaringen", testament: "nieuw", booksequence: 66) }


  before do
    visit pericopes_path
  end

  scenario "Ordered by testament" do
    expect(page).to have_content "Oude Testament"
    expect(page).to have_content "Nieuwe Testament"
  end

  scenario "Grouped by biblebook", js: true do
    page.click_on('Oude Testament')
    expect(page).to have_content "Jona"
    expect(page).to have_content "Maleachi"

    click_link "Nieuwe Testament"
    expect(page).to have_content "Mattheus"
    expect(page).to have_content "Openbaringen"
  end

=begin

  let!(:b1) { create(:biblebook, name: "Jona", booksequence: 34) }
  let!(:s1) { create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user) }
  let!(:p1) { create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id) }

  let!(:b2) { create(:biblebook, name: "Handelingen", booksequence: 53) }

  let!(:s3) { create(:studynote, title: "Handelingen later", note: "Handelingen ook.", author: user) }
  let!(:p3) { create(:pericope_by_name, name: "Handelingen 1:2 - 1:10", biblebook_id: b2.id, studynote_id: s3.id) }

  let!(:s2) { create(:studynote, title: "Handelingen eerst", note: "Handelingen ook.", author: user) }
  let!(:p2) { create(:pericope_by_name, name: "Handelingen 1:1 - 1:10", biblebook_id: b2.id, studynote_id: s2.id) }

  let!(:s4) { create(:studynote, title: "Handelingen alles", note: "Handelingen ook.", author: user) }
  let!(:p4) { create(:pericope_by_name, name: "Handelingen", biblebook_id: b2.id, studynote_id: s4.id) }


  scenario "sorted by biblebook name" do
    expect(page).to have_content "Jona"
    expect(page).to have_content "Handelingen"

    save_and_open_page
    expect("Jona").to appear_before("Handelingen")
  end

  scenario "sorted by chapter number" do
    expect("Handelingen eerst").to appear_before("Handelingen later")
    expect("Handelingen alles").to appear_before("Handelingen eerst")
  end

  scenario "grouped by biblebook" do
    expect(page).to have_content "Handelingen"
    within("//li[@id='Handelingen']") do
      expect(page).to have_content "Jona is bijzonder."
      expect(page).to_not have_content "Handelingen"
    end

    expect(page).to have_content "Jona"
    within("//li[@id='Jona']") do
      expect(page).to have_content "Handelingen eerst"
      expect(page).to have_content "Handelingen later"
      expect(page).to have_content "Handelingen alles"
      expect(page).to_not have_content "Jona"
    end
  end

  scenario "and view the details of a studynote" do
    click_link "Jona"
    expect(page).to have_content "Jona is bijzonder"
  end
=end
end
