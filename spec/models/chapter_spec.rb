# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id             :integer          not null, primary key
#  chapter_number :integer
#  description    :string
#  nrofverses     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  biblebook_id   :integer
#
# Indexes
#
#  index_chapters_on_biblebook_id  (biblebook_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#
RSpec.describe Chapter, type: :model do
  let(:early) { build(:chapter, chapter_number: 1) }
  let(:late) { build(:chapter, chapter_number: 2) }
  let(:chap) { build(:chapter, chapter_number: 1, nrofverses: 2) }

  it "compares different chapters" do
    expect(late > early).to be(true)
  end

  # :reek:FeatureEnvy
  it "validates if verses are in range" do
    expect(chap.valid_verse?(2)).to be(true)
    expect(chap.valid_verse?(0)).to be(false)
    expect(chap.valid_verse?(3)).to be(false)
  end
end
