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
    new_name = biblebook_name
    if starting_chapter_nr != 0
      new_name = starting_chapter(new_name)
      if starting_verse != 0
        if ending_chapter_nr > starting_chapter_nr
          new_name = full_pericope(new_name)
        elsif ending_verse > starting_verse
          new_name = same_chapter(new_name)
        elsif ending_verse == starting_verse
          new_name = one_verse(new_name)
        end
      end
    end
    self.name = new_name
  end

  private

  def starting_chapter(new_name)
    new_name << ' '
    new_name << starting_chapter_nr.to_s
  end

  def full_pericope(new_name)
    new_name << ':'
    new_name << starting_verse.to_s
    new_name << ' - '
    new_name << ending_chapter_nr.to_s
    new_name << ':'
    new_name << ending_verse.to_s
  end

  def same_chapter(new_name)
    new_name << ':'
    new_name << starting_verse.to_s
    new_name << ' - '
    new_name << ending_verse.to_s
  end

  def one_verse(new_name)
    new_name << ':'
    new_name << starting_verse.to_s
  end
end
