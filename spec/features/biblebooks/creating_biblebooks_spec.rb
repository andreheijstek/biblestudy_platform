require "rails_helper"

feature "Admins can create new bible sections" do

  before do
    visit "/"
    click_link t(:new_biblebook)
  end

  scenario "for single bible books" do
    bookname = "Handelingen"
    fill_in "Name", with: bookname
    fill_in "Description", with: "De handelingen der apostelen"
    click_button "Create Biblebook"
    expect(page).to have_content t(:biblebook_created)

    book = Biblebook.find_by(name: "Handelingen")
    expect(page.current_url).to eq biblebook_url(book)
    title = "#{bookname} - #{t(:biblebooks)} - #{t(:biblestudy_platform)}"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    click_button "Create Biblebook"
    expect(page).to have_content t(:biblebook_not_created)
    expect(page).to have_content "can't be blank"
  end
end
