# frozen_string_literal: true

# TODO: There's apparently quite a lot of work to do here still
feature 'Users can delete pericopes', js: true do
  let(:user) { create(:user) }
  let(:studynote) do
    create(
      :studynote,
      pericope: 'Jona 1:1-5',
      title: 'Jona met 1 perikoop',
      note: 'zomaar iets'
    )
  end
  let(:nsp) { NewStudynotesPage.new }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)

    nsp.load
    nsp.title_field.set('Titel')
    nsp.studynote_field.set('Jona is bijzonder.')
  end

  scenario 'a second pericope' do
    nsp.pericopes[0].set('Jona 1:1 - 1:10')
    nsp.add_pericope_button.click
    nsp.pericopes[1].set('Jona 2:20 - 3:3')

    # TODO: Assert afmaken
    # nsp.remove_pericope_button[1].click
    #
    # should_not_see "perikoop 2"
  end

  scenario 'but not the first/only one' do
    nsp.pericopes[0].set('Jona 1:1 - 1:10')
    nsp.remove_pericope_button[0].click

    # TODO: I don't know how to test the alert here.
    # It is possible to test an alert in a controller test, why not here?
    # Maybe I should not raise an alert anyway, but raise the error message
    # from the coffee-script up to the controller. But that's too hard for now.
    # The check is working well, the test comes later, hopefully
    # should_see t('at_least_one_pericope')
    # expect(flash[:alert]).to eq t('at_least_one_pericope')
  end
end
