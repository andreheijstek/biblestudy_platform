# frozen_string_literal: true

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

# Models a Pericope as a Range of a StartingVerse and an EndingVerse
class PericopeAsRange < ApplicationRecord
  include Comparable

  belongs_to :starting_verse,
             class_name:  'BibleVerse',
             foreign_key: 'starting_verse_id'
  belongs_to :ending_verse,
             class_name:  'BibleVerse',
             foreign_key: 'ending_verse_id'

  validates_presence_of :starting_verse
  validates_presence_of :ending_verse
  validate :single_biblebook

  def single_biblebook
    return if starting_verse.biblebook.name == ending_verse.biblebook.name
    errors.add(:pericope_as_range,
               'a pericope should be confined to a single biblebook')
  end
end
