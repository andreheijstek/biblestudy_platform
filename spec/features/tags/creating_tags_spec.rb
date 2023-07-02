# frozen_string_literal: true

feature "creating tags" do
  let!(:user) { create(:user) }
  let!(:studynote) { create(:studynote, :pericope, author: user) }
  let(:ssp) { ShowStudynotePage.new }

  before { login_as(user) }

  after do
    studynote.tag_list = @tag
    studynote.save
    ssp.load studynote: studynote.id
    expect(page).to have_content @tag
  end

  scenario "single tag" do
    @tag = "my_tag"
  end

  scenario "multiple tags" do
    @tag = "my_tag, my_other_tag"
  end

  scenario "multiword tags" do
    @tag = "my tag"
  end

  scenario "multiple multiword tags" do
    @tag = "my tag, my_tag, yet another tag"
  end
end
