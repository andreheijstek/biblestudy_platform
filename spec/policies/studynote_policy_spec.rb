require 'rails_helper'

RSpec.describe StudynotePolicy do
  permissions :show? do
    let(:user) { FactoryGirl.create :user }
    let(:studynote) { FactoryGirl.create :studynote }

    subject { StudynotePolicy }

    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, studynote)
    end

    it "allows students of the studynote" do
      assign_role!(user, :student, studynote)
      expect(subject).to permit(user, studynote)
    end

    it "allows administrators" do
      admin = FactoryGirl.create :user, :admin
      expect(subject).to permit(admin, studynote)
    end
  end
end
