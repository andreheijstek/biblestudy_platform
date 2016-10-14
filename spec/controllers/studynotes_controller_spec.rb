=begin
require "rails_helper"

describe StudynotesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  it "handles permission errors by redirecting to a safe place" do
    allow(controller).to receive(:current_user)
    b1 = create(:biblebook, name: "Jona")
    s1 = create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user)
    FactoryGirl.create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id)

    get :update, studynote: s1
# TODO: not working on this get, No route matches {:action=>"update", :controller=>"studynotes", :studynote=>"215"}

    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
=end
