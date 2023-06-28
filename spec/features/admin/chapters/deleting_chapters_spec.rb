# frozen_string_literal: true

feature "Users can delete chapters" do
  let(:biblebook) { create(:biblebook) }
  let(:chapter) { create(:chapter, biblebook: biblebook) }

  before do
    login_as(create(:user, :admin))
    visit admin_biblebook_chapter_path(biblebook, chapter)
  end

  scenario "successfully" do
    page.accept_alert "Weet u zeker dat u dit hoofdstuk wilt verwijderen?" do
      click_link t(:delete_item, item: Chapter.model_name.human)
    end
    should_see t(:item_deleted, item: Chapter.model_name.human)
  end
end
