# frozen_string_literal: true

feature "tag overview" do
  let!(:my_studynote) { create(:studynote, :pericope) }
  let(:top) { TagsOverviewPage.new }

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
    expect('a_tag').to appear_before('z_tag')
  end
end
