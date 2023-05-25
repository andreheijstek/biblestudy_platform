# frozen_string_literal: true

# == Schema Information
#
# Table name: pericopes
#
#  id             :integer          not null, primary key
#  biblebook_name :string
#  name           :string
#  sequence       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  biblebook_id   :integer
#  end_verse_id   :bigint
#  start_verse_id :bigint
#  studynote_id   :integer
#
# Indexes
#
#  index_pericopes_on_biblebook_id    (biblebook_id)
#  index_pericopes_on_end_verse_id    (end_verse_id)
#  index_pericopes_on_start_verse_id  (start_verse_id)
#  index_pericopes_on_studynote_id    (studynote_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#  fk_rails_...  (end_verse_id => bible_verses.id)
#  fk_rails_...  (start_verse_id => bible_verses.id)
#  fk_rails_...  (studynote_id => studynotes.id)
#

# The caller should create the correct biblebook before calling
# Pericope_xxx_Factory

FactoryBot.define do
  factory :pericope, class: "Pericope" do
    name { "Jona 1:1 - 1:10" }
    trait :jona do
      biblebook do
        Biblebook.find_by(name: "Jona") ||
          FactoryBot.create(:biblebook, name: "Jona")
      end
    end
  end
end
