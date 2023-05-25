# frozen_string_literal: true

#
# TODO: To be completed, testing the messages is important!

feature "Users can not create new studynotes", js: true do
  let(:user) { create(:user) }
  let(:nsp) { NewStudynotesPage.new }

  before do
    create(:biblebook, name: "Jona")
    create(:biblebook, name: "Job")
    create(:biblebook, name: "Johannes")
    login_as(user)

    nsp.load
  end

  scenario "when providing no attributes" do
    nsp.submit_button.click
    should_see t("activerecord.models.messages.blank")
  end

  context "with incorrect data" do
    before { nsp.title_field.set "Titel" }

    scenario "when providing out of sequence chapters and verses" do
      nsp.pericopes[0].set "Jona 3:1 - 1:10"
      nsp.studynote_field.set "Studie"

      nsp.submit_button.click

      # TODO: Assert afmaken
      # should_see t('errors.messages.verse_chapter_disorder')
      should_see t("item_not_created", item: "bijbelstudie")
    end

    # scenario 'when providing just the title' do
    #   nsp.studynote_field.set 'Studie'
    #
    #   nsp.submit_button.click
    #
    # TODO: Assert afmaken
    #   should_see 'moet opgegeven zijn'
    # end

    scenario "when providing an incorrect biblebook" do
      nsp.pericopes[0].set "Jo 1:1 - 1:10"
      nsp.studynote_field.set "Studie"

      nsp.submit_button.click

      # TODO: Assert afmaken
      # should_see "#{t('errors.messages.ambiguous_abbreviation',
      #                 given_name: 'Jo',
      #                 biblebooks: %w[Jona Job Johannes].to_sentence)}"
      should_see t("item_not_created", item: "bijbelstudie")
    end
  end
end
