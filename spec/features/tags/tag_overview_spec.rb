# frozen_string_literal: true

feature "tag overview" do
  let!(:user) { create(:user) }
  let!(:my_studynote) { create(:studynote, :pericope) }
  let(:top) { TagsOverviewPage.new }

  before { login_as(user) }

  scenario "all tags are shown on the overview page" do
    my_studynote.tag_list = "my_tag"
    my_studynote.save
    top.load
    top.tags_button.click
    expect(page).to have_content("my_tag")
  end

  scenario "tags are sorted alphabetically" do
    my_studynote.tag_list = "a_tag, z_tag"
    my_studynote.save
    top.load
    top.tags_button.click
    expect("a_tag").to appear_before("z_tag")
  end

  scenario "tags show how often they occur" do
    my_studynote.tag_list = "a_tag"
    my_studynote.save
    top.load
    top.tags_button.click
    within "#tags" do
      expect(page).to have_content("a_tag (1)")
    end
  end

  scenario "if tags are only used once, they directly link to the studynote" do
    title = "follow the title"
    my_studynote.tag_list = "a_tag"
    my_studynote.title = title
    my_studynote.author = user
    my_studynote.save
    top.load
    top.tags_button.click
    click_link "a_tag"
    expect(page).to have_content title
  end
end
