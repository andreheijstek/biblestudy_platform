# frozen_string_literal: true

describe "Users can view an overview of all studynotes", js: true do
  let!(:user) { create(:user) }

  let(:sno) { StudynotesOverviewPage.new }

  let!(:book_jona) do
    create(:biblebook, name: "Jona", testament: "oud", booksequence: 34)
  end

  let!(:book_handelingen) do
    create(
      :biblebook,
      name: "Handelingen",
      testament: "nieuw",
      booksequence: 53
    )
  end

  let!(:study_jona) do
    create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user)
  end

  let!(:study_hand_eerst) do
    create(
      :studynote,
      title: "Handelingen later",
      note: "Handelingen ook.",
      author: user
    )
  end

  let!(:study_hand_later) do
    create(
      :studynote,
      title: "Handelingen eerst",
      note: "Handelingen ook",
      author: user
    )
  end

  before do
    create(
      :pericope,
      name: "Jona 1:1 - 1:10",
      biblebook_id: book_jona.id,
      studynote_id: study_jona.id
    )
    create(
      :pericope,
      name: "Handelingen 1:1 - 1:10",
      biblebook_id: book_handelingen.id,
      studynote_id: study_hand_later.id
    )
    create(
      :pericope,
      name: "Handelingen 1:2 - 1:10",
      biblebook_id: book_handelingen.id,
      studynote_id: study_hand_eerst.id
    )
    create(
      :studynote,
      title: "Handelingen eerst",
      note: "Handelingen ook",
      author: user
    )
    sno.load
  end

  scenario "showing the number of studynotes per biblebook" do
    open_accordion("Oude Testament")
    expect(page).to have_content("Jona (1)")

    open_accordion("Nieuwe Testament")
    expect(page).to have_content("Handelingen")
  end

  scenario "sorted by chapter number" do
    expect("Handelingen eerst").to appear_before("Handelingen later")
  end

  scenario "grouped by biblebook" do
    books = sno.biblebooks
    jona = books[0]

    within(jona) do
      expect(page).not_to have_content("Handelingen eerst")
      expect(page).not_to have_content("Handelingen later")
      expect(page).to have_content("Jona")
    end

    open_accordion "Nieuwe Testament"
    open_accordion "Handelingen"

    books = sno.biblebooks
    handelingen = books[0]
    sn = sno.studynotes

    expect(handelingen.text).to start_with("Handelingen")

    within(handelingen) do
      expect(page).not_to have_content("Jona is bijzonder.")
      expect(page).to have_content("Handelingen")
    end
  end

  scenario "and view the details of a studynote" do
    click_link "Jona"
    expect(page).to have_content("Jona is bijzonder")
  end
end

def open_accordion(text)
  click_button(text)
end
