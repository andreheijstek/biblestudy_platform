# frozen_string_literal: true

describe "Users can create new studynotes with a single pericope", js: true do
  let(:user) { create(:user) }
  let(:nsp) { NewStudynotesPage.new }

  before do
    create(:biblebook, name: "Jona")
    login_as(user)

    nsp.load
  end

  it "with valid attributes" do
    fill_and_submit("Jona 1:1 - 1:10")
    expect(page).to have_content ("Jona 1:1 - 1:10")
  end

  it "containing just one single verse" do
    fill_and_submit("Jona 1:1")

    expect(page).to have_content ("Jona 1:1")
  end

  # TODO: Make this helper available to many more tests?
  def fill_and_submit(pericope)
    nsp.pericopes[0].set pericope
    nsp.title_field.set "Titel"
    nsp.studynote_field.set "Jona is bijzonder."
    nsp.submit_button.click
  end
end
