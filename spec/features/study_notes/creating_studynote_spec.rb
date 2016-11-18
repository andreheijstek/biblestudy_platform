require "rails_helper"

feature "Users can create new studynotes and associate them to pericopes" do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: "Jona")
    login_as(user)
    visit studynotes_path
    click_link t(:new_studynote)
  end

  scenario "to a single pericopes with valid attributes" do
    fill_in t('simple_form.labels.pericopes.name'), with: "Jona 1:1 - 1:10"
    fill_in t('simple_form.labels.studynote.title'), with: "Titel"
    fill_in t('simple_form.labels.studynote.note'), with: "Jona is bijzonder."

    submit_form

    expect(page).to have_content t(:studynote_created)
    within("#studynote") do
      expect(page).to have_content "#{t("author")}: #{user.email}"
    end
  end

  scenario "when providing no attributes" do
    submit_form
    expect(page).to have_content t(:studynote_not_created)
    expect(page).to have_content t('activerecord.models.messages.blank')
  end

  scenario "when providing just the title" do
    fill_in t('simple_form.labels.studynote.title'), with: "Titel"
    submit_form
    expect(page).to have_content t(:studynote_not_created)
    expect(page).to have_content t('activerecord.models.messages.blank')
  end

  context "abbreviated biblebooks" do
    before do
      create(:biblebook, name: "Genesis", abbreviation: "Gen")
      create(:biblebook, name: "Exodus", abbreviation: "Ex")
      create(:biblebook, name: "1 Koningen", abbreviation: "1 Kon")
      create(:biblebook, name: "1 Kronieken", abbreviation: "1 Kron")
      create(:biblebook, name: "1 Korintiërs", abbreviation: "1 Kor")
      create(:biblebook, name: "2 Korintiërs", abbreviation: "2 Kor")
    end

    examples = [
        # [pericope, title, studynote] => method_result
        { :inputs => "Gen 1:1 - 1:10",            :expected => "Genesis 1:1 - 1:10" },
        { :inputs => "Ex 1:1 - 1:10",             :expected => "Exodus 1:1 - 1:10" },
        { :inputs => "1 Kon 1:1 - 1:10",          :expected => "1 Koningen 1:1 - 1:10" },
        { :inputs => "1 Kron 1:1 - 1:10",         :expected => "1 Kronieken 1:1 - 1:10" },
        { :inputs => "1 Kor 1:1 - 1:10",          :expected => "1 Korintiërs 1:1 - 1:10" },
        { :inputs => "1 Korintiërs 1:1 - 1:10",   :expected => "1 Korintiërs 1:1 - 1:10" },
        { :inputs => "1 Korintiers 1:1 - 1:10",   :expected => "1 Korintiërs 1:1 - 1:10" },
        { :inputs => "1 Korinthiërs 1:1 - 1:10",  :expected => "1 Korintiërs 1:1 - 1:10" },
        { :inputs => "1 Korinthiers 1:1 - 1:10",  :expected => "1 Korintiërs 1:1 - 1:10" },
        { :inputs => "2 Kor 1:1 - 1:10",          :expected => "2 Korintiërs 1:1 - 1:10" }
    ]
    examples.each do |example|
      inputs = example[:inputs]

      it "should add a studynote with abbreviated biblebook #{example[:inputs]} as #{example[:expected]}" do
        fill_in t('simple_form.labels.pericopes.name'), with: "#{example[:inputs]}"
        fill_in t('simple_form.labels.studynote.title'), with: "abbr"
        fill_in t('simple_form.labels.studynote.note'), with: "bijbelstudie"

        submit_form

        expect(page).to have_content t(:studynote_created)
        within("#studynote") do
          expect(page).to have_content "#{example[:expected]}"
        end

        visit pericopes_path
        expect(page).to have_content "bijbelstudie"
      end
    end
  end

  scenario "when providing an abbreviated biblebook for Genesis" do
    create(:biblebook, name: "Genesis", abbreviation: "Gen")

    fill_in t('simple_form.labels.pericopes.name'), with: "Gen 1:1 - 1:10"
    fill_in t('simple_form.labels.studynote.title'), with: "Genesis in het kort"
    fill_in t('simple_form.labels.studynote.note'), with: "bijbelstudie"

    submit_form

    expect(page).to have_content t(:studynote_created)
    within("#studynote") do
      expect(page).to have_content "Genesis 1:1 - 1:10"
    end

    visit pericopes_path
    expect(page).to have_content "Genesis in het kort"
  end

  scenario "when providing an abbreviated biblebook for Psalmen as Ps" do
    create(:biblebook, name: "Psalmen", abbreviation: "Ps")

    fill_in t('simple_form.labels.pericopes.name'), with: "Ps 149:1-14"
    fill_in t('simple_form.labels.studynote.title'), with: "Ps een Psalm"
    fill_in t('simple_form.labels.studynote.note'), with: "Psalm"

    submit_form

    expect(page).to have_content t(:studynote_created)
    within("#studynote") do
      expect(page).to have_content "Psalmen 149:1 - 149:14"
    end

    visit pericopes_path
    expect(page).to have_content "Ps een Psalm"
  end


  scenario "when providing an abbreviated biblebook for Psalmen as Psalm" do
    create(:biblebook, name: "Psalmen", abbreviation: "Ps")

    fill_in t('simple_form.labels.pericopes.name'), with: "Psalm 149:1-14"
    fill_in t('simple_form.labels.studynote.title'), with: "Ps een Psalm"
    fill_in t('simple_form.labels.studynote.note'), with: "Psalm"

    submit_form

    expect(page).to have_content t(:studynote_created)
    within("#studynote") do
      expect(page).to have_content "Psalmen 149:1 - 149:14"
    end

    visit pericopes_path
    expect(page).to have_content "Ps een Psalm"
  end

  # TODO Add several more examples of biblebooks/abbreviations
  # Look for close matches
  # Is there a scenario outline like construction possible?
  # Or, maybe better: turn into Cucumber!

  ## lowercase

  # scenario "to multiple pericopes" do
  # end
end
