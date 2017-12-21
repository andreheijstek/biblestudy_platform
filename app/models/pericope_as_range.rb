# == Schema Information
#
# Table name: pericope_as_ranges
#
#  id                :integer          not null, primary key
#  name              :string
#  starting_verse_id :integer
#  ending_verse_id   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PericopeAsRange < ApplicationRecord
  belongs_to :starting_verse, class_name: 'BibleVerse', foreign_key: 'starting_verse_id'
  belongs_to :ending_verse, class_name: 'BibleVerse', foreign_key: 'ending_verse_id'
end
