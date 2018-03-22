Given("there is a biblebook {string} in the testament {string}") do |biblebook, testament|
  @book = create(:biblebook, name: biblebook, testament: testament, booksequence: 34)
end

Given("there is a study on {string}") do |pericope|
  @study    = create(:studynote, title: "#{pericope}-title", note: "#{pericope}-note", author: @user)
  @pericope = create(:pericope, name: pericope, biblebook_id: @book.id, studynote_id: @study.id)
end

When("I look at the overview") do
  @overview_page = StudynoteOverview.new
  @overview_page.load
  save_and_open_page
end

Then("{string} should be shown before {string}") do |before, after|
  expect(before).to appear_before(after)
end
