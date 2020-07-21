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
RSpec.describe Chapter, type: :model do
  let(:early) { build(:chapter, chapter_number: 1) }
  let(:late) { build(:chapter, chapter_number: 2) }

  it 'compares different chapters' do
    expect(late > early).to be(true)
  end
end
