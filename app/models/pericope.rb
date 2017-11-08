# frozen_string_literal: true

# == Schema Information
#
# Table name: pericopes
#
#  id                  :integer          not null, primary key
#  studynote_id        :integer
#  starting_verse      :integer
#  ending_verse        :integer
#  biblebook_id        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string
#  ending_chapter_nr   :integer
#  starting_chapter_nr :integer
#  biblebook_name      :string
#  sequence            :integer
#

class Pericope < ActiveRecord::Base
  belongs_to :studynote
  belongs_to :biblebook

  validates :name, presence: true
  validates_with PericopeValidator
  after_validation :reformat_name

  def reformat_name
    return unless errors.empty?
    new_name = +''
    new_name << biblebook_name
    if starting_chapter_nr != 0
      # Chapter filled, so this is not just a complete biblebook
      new_name << ' '
      new_name << starting_chapter_nr.to_s
      if starting_verse != 0
        # there are verses, so this is not a whole chapter
        if ending_chapter_nr > starting_chapter_nr
          # multiple chapters, so publish a full 4 element string (1:2-3:4)
          new_name << ':'
          new_name << starting_verse.to_s
          new_name << ' - '
          new_name << ending_chapter_nr.to_s
          new_name << ':'
          new_name << ending_verse.to_s
        elsif ending_verse > starting_verse
          # whole pericope, but within the same chapter (1:2-8)
          new_name << ':'
          new_name << starting_verse.to_s
          new_name << ' - '
          new_name << ending_verse.to_s
        elsif ending_verse == starting_verse
          # pericope consisting of just one verse (1:2)
          new_name << ':'
          new_name << starting_verse.to_s
        end
      end
    end
    self.name = new_name
  end
end
