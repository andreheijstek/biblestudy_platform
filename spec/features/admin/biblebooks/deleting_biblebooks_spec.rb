# frozen_string_literal: true

feature "Users can delete biblebooks" do
  before { login_as(create(:user, :admin)) }

  scenario "successfully" do
    create(:biblebook, name: "Handelingen")
    visit admin_biblebooks_path
    click_link "Handelingen"

    click_link t(:delete_item, item: Biblebook.model_name.human)

    should_see t("errors.messages.biblebook_deleted")
    expect(page.current_url).to eq admin_biblebooks_url
    expect(page).to have_no_content "Handelingen"
  end
end
