require "rails_helper"

feature "Admins can create new bible sections" do

  before do
    visit "/"
    click_link t(:new_biblebook)
  end

  scenario "for single bible books" do
    bookname = "Handelingen"
    fill_in t(:name), with: bookname
    fill_in t(:description), with: "De handelingen der apostelen"

    # TODO: This is not DRY. I have a name and description as attributes of biblebook, but don't know how
    #       to access them here, therefore I have also created a separate name and description

    # click_button "Create Biblebook"
    submit
    expect(page).to have_content t(:biblebook_created)

    book = Biblebook.find_by(name: "Handelingen")
    expect(page.current_url).to eq biblebook_url(book)
    title = "#{bookname} - #{t(:biblebooks)} - #{t(:biblestudy_platform)}"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    submit
    expect(page).to have_content t(:biblebook_not_created)
    expect(page).to have_content t(:blank, scope: [:activerecord, :models, :messages])
  end
end

def submit
  find(:name, 'commit').click

end
