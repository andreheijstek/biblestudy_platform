# frozen_string_literal: true

feature "tag overview" do
  let(:user) { create(:user) }
  let(:jona) { create(:biblebook) }
  let(:studynote) do
    create(
    :studynote,
    pericope: "Jona 1:1-5",
    title:    "Jona met 1 perikoop",
    note:     "zomaar iets",
    tag:      "een_tag"
    )
  end
  let(:top) { TagsOverviewPage.new }

  scenario 'all tags are shown on the overview page' do
    top.load
    # top.tags_button.click
    #
    # expect(true).to eq(false)
  end
end
