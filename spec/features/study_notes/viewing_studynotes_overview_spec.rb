# frozen_string_literal: true

describe "Users can view an overview of all studynotes" do
  let!(:user) { create(:user) }

  let(:sno) { StudynotesOverviewPage.new }

  let!(:book_jona) do
    create(:biblebook, name: "Jona", testament: "oud", booksequence: 34)
  end

  let!(:book_handelingen) do
    create(
    :biblebook,
    name:         "Handelingen",
    testament:    "nieuw",
    booksequence: 53
    )
  end

  let!(:chap1) do
    create(
    :chapter,
    chapter_number: 1,
    nrofverses:     3,
    biblebook_id:   book_handelingen.id
    )
  end
  let!(:chap2) do
    create(
    :chapter,
    chapter_number: 2,
    nrofverses:     10,
    biblebook_id:   book_handelingen.id
    )
  end

  let!(:study_jona) do
    create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user)
  end
  let!(:pericope_jona) do
    create(
    :pericope,
    name:         "Jona 1:1 - 1:10",
    biblebook_id: book_jona.id,
    studynote_id: study_jona.id
    )
  end

  let!(:study_hand1) do
    create(
    :studynote,
    title:  "Handelingen later",
    note:   "Handelingen ook.",
    author: user
    )
  end
  let!(:pericope_hand1) do
    create(
    :pericope,
    name:         "Handelingen 1:2 - 1:10",
    biblebook_id: book_handelingen.id,
    studynote_id: study_hand1.id
    )
  end

  let!(:study_hand2) do
    create(
    :studynote,
    title:  "Handelingen eerst",
    note:   "Handelingen ook.",
    author: user
    )
  end
  let!(:pericope_hand2) do
    create(
    :pericope,
    name:         "Handelingen 1:1 - 1:10",
    biblebook_id: book_handelingen.id,
    studynote_id: study_hand2.id
    )
  end

  before do
    visit pericopes_path
    sno.load
  end

  scenario "showing the number of studynotes per biblebook" do
    page.click_on("Oude Testament")
    expect(page).to have_content ("Jona (1)")

    page.click_on("Nieuwe Testament")
    expect(page).to have_content ("Handelingen (2)")
  end

  scenario "sorted by chapter number" do
    expect("Handelingen eerst").to appear_before("Handelingen later")
  end

  scenario "grouped by biblebook" do
    books       = sno.biblebooks
    jona        = books[0]
    handelingen = books[1]
    sn          = sno.studynotes

    expect(handelingen.text).to start_with("Handelingen")
    expect(sn[1].text).to include("Handelingen")

    within(handelingen) do
      expect(page).to_not have_content ("Jona is bijzonder.")
      expect(page).to have_content ("Handelingen")
    end

    within(jona) do
      expect(page).to_not have_content ("Handelingen eerst")
      expect(page).to_not have_content ("Handelingen later")
      expect(page).to have_content ("Jona")
    end
  end

  scenario "and view the details of a studynote" do
    click_link "Jona"
    expect(page).to have_content ("Jona is bijzonder")
  end

  scenario "having the accordion open when there is content" do
    expect(page).to have_content ("Jona")
    expect(page).to have_content ("Handelingen eerst")
  end
end
