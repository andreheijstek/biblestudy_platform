require "rails_helper"

feature "Users can edit existing biblebooks" do
  before do
    login_as(create(:user, :admin))
    create(:biblebook, name: "Voorbeeld bijbelboek")
    visit admin_biblebooks_path

    click_link "Voorbeeld bijbelboek"
    click_link t(:edit_bibilebook)
  end

  scenario "with valid attributes" do
    fill_in t("simple_form.labels.biblebook.name"), with: "Acts"

    submit_form

    should_see t(:biblebook_updated)
    should_see "Acts"
  end

  scenario "when providing invalid attributes" do
    fill_in t("simple_form.labels.biblebook.name"), with: ""
    submit_form
    should_see t(:biblebook_not_updated)
  end
end
