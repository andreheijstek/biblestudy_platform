require "rails_helper"

feature "Users can view an overview of all studynotes" do
  let(:user) { create(:user) }
  let!(:book_jona)         { create(:biblebook, name: "Jona", testament: "oud", booksequence: 34) }
  let!(:book_maleachi)     { create(:biblebook, name: "Maleachi", testament: "oud", booksequence: 45) }
  let!(:book_mattheus)     { create(:biblebook, name: "Mattheus", testament: "nieuw", booksequence: 51) }
  let!(:book_openbaringen) { create(:biblebook, name: "Openbaringen", testament: "nieuw", booksequence: 66) }
  let!(:book_handelingen)  { create(:biblebook, name: "Handelingen", testament: "nieuw", booksequence: 53) }

  let!(:study_jona)        { create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user) }
  let!(:pericope_jona)     { create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: book_jona.id, studynote_id: study_jona.id) }

  let!(:study_hand1)       { create(:studynote, title: "Handelingen later", note: "Handelingen ook.", author: user) }
  let!(:pericope_hand1)    { create(:pericope_by_name, name: "Handelingen 1:2 - 1:10", biblebook_id: book_handelingen.id, studynote_id: study_hand1.id) }

  let!(:study_hand2)       { create(:studynote, title: "Handelingen eerst", note: "Handelingen ook.", author: user) }
  let!(:pericope_hand2)    { create(:pericope_by_name, name: "Handelingen 1:1 - 1:10", biblebook_id: book_handelingen.id, studynote_id: study_hand2.id) }

  let!(:study_hand3)       { create(:studynote, title: "Handelingen alles", note: "Handelingen ook.", author: user) }
  let!(:pericope_hand3)    { create(:pericope_by_name, name: "Handelingen", biblebook_id: book_handelingen.id, studynote_id: study_hand3.id) }

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

  scenario "Showing the number of studynotes per biblebook" do
    page.click_on('Oude Testament')
    expect(page).to have_content "Jona (1)"

    page.click_on('Nieuwe Testament')
    expect(page).to have_content "Handelingen (3)"
  end

  scenario "Containing studynotes" do
    page.click_on('Oude Testament')
    page.click_on('Jona')
    expect(page).to have_content "Jona is bijzonder"
  end

  scenario "sorted by biblebook name" do
    expect(page).to have_content "Jona"
    expect(page).to have_content "Handelingen"

    expect("Jona").to appear_before("Handelingen")
  end


  scenario "sorted by chapter number" do
    save_and_open_page
    expect("Handelingen eerst").to appear_before("Handelingen later")
    expect("Handelingen alles").to appear_before("Handelingen eerst")
  end

=begin

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
