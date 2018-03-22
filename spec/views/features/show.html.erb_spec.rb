require 'rails_helper'

RSpec.describe "features/show", type: :view do
  before(:each) do
    @feature = assign(:feature, Feature.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
