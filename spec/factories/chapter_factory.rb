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

FactoryBot.define do
  factory :chapter do
    chapter_number { "0" }
    description { "Example description" }
  end
end
