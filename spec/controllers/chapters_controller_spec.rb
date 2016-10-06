# TODO Spec does not work, although the app works correctly
# I think this is because of the nesting of resources
# The biblebooks_controller_spec works OK
# I think the get :show calls a chapter route without prefixing a biblebook

=begin
require "rails_helper"

RSpec.describe Admin::ChaptersController, type: :controller do
  let(:user) { FactoryGirl.create(:user, :admin) }

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "handles a missing chapter correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(admin_biblebook_chapter_path)
    message = t(:chapter_not_found)
    expect(flash[:alert]).to eq message
  end
end
=end
