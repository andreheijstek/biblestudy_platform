# frozen_string_literal: true

feature 'Users can view an overview of all biblebooks' do
  before { login_as(create(:user, :admin)) }

  # rubocop:disable RSpec/ExpectActual
  scenario 'sorted by the given order' do
    create(:biblebook, name: 'Bijbelboek1', booksequence: 1)
    create(:biblebook, name: 'Bijbelboek2', booksequence: 2)
    visit admin_biblebooks_path

    expect('Bijbelboek1').to appear_before('Bijbelboek2')
  end
  # rubocop:enable RSpec/ExpectActual
end
