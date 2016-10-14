require 'rails_helper'

describe StudynotePolicy do
  let(:user)      { FactoryGirl.create :user }
  let(:studynote) { FactoryGirl.create :studynote }

  permissions :show? do
    subject { StudynotePolicy }

    it "allows everybody to view everything" do
      expect(subject).to permit(nil, studynote)
    end

    it "allows administrators" do
      admin = FactoryGirl.create :user, :admin
      expect(subject).to permit(admin, studynote)
    end
  end

  permissions :update?, :destroy? do
    let(:user) { FactoryGirl.create :user }
    let(:studynote) { FactoryGirl.create :studynote, author: user }

    subject { StudynotePolicy }

    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, studynote)
    end

    it "blocks registered users who are not the author" do
      other_user = FactoryGirl.create :user
      expect(subject).not_to permit(other_user, studynote)
    end

    it "allows registered users who are the author" do
      expect(subject).to permit(user, studynote)
    end

    it "allows administrators" do
      admin = FactoryGirl.create :user, :admin
      expect(subject).to permit(admin, studynote)
    end
  end

  permissions :create? do
    subject { StudynotePolicy }

    # it "blocks anonymous users" do
    #   expect(subject).not_to permit(nil, studynote)
    # end

    it "allows registered users" do
      expect(subject).to permit(user, studynote)
    end

    it "allows administrators" do
      admin = FactoryGirl.create :user, :admin
      expect(subject).to permit(admin, studynote)
    end
  end
end
