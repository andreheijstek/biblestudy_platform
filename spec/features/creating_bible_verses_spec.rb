require "rails_helper"

feature "Admins can create new bible sections" do

  let (:handelingen) { FactoryGirl.create(:biblebook) }

  before do
    visit "/"
    click_link "New biblebook"
  end

  scenario "for single bible books" do
    fill_in "Name", with: "Handelingen"
    fill_in "Description", with: "De handelingen der apostelen"
    click_button "Create Biblebook"
    expect(page).to have_content "Biblebook has been created."

    book = Biblebook.find_by(name: "Handelingen")
    expect(page.current_url).to eq biblebook_url(book)
    title = "Handelingen - Biblebooks - Biblestudy-platform"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    click_button "Create Biblebook"
    expect(page).to have_content "Biblebook has not been created."
    expect(page).to have_content "Name can't be blank"
  end

  scenario "for single chapters within a biblebook" do
    visit biblebook_path(handelingen)
    click_link "New Chapter"
    fill_in "Number", with: "1"
    click_button "Create Chapter"
    expect(page).to have_content "Chapter has been created."
  end
end
