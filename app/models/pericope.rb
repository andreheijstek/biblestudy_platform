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

# Models a Pericope, e.g. Gen 1:2-3:4
# Offers a method to reformat an abbreviated Pericope
# into a fully articulated one
class Pericope < ActiveRecord::Base
  belongs_to :studynote
  belongs_to :biblebook

  validates :name, presence: true
  validates_with PericopeValidator
  after_validation :reformat_name

  def reformat_name
    return unless errors.empty?
    new_name = biblebook_name.dup
    unless whole_book?
      new_name += starting_chapter
      new_name += add_verses unless whole_chapter?
    end
    self.name = new_name
  end

  private

  def add_verses
    if multiple_chapters?
      full_pericope
    elsif multiple_verses?
      same_chapter
    elsif one_verse?
      one_verse
    end
  end

  def whole_chapter?
    starting_verse.zero?
  end

  def whole_book?
    starting_chapter_nr.zero?
  end

  def one_verse?
    ending_verse == starting_verse
  end

  def multiple_verses?
    ending_verse > starting_verse
  end

  def multiple_chapters?
    ending_chapter_nr > starting_chapter_nr
  end

  def starting_chapter
    " #{starting_chapter_nr}"
  end

  def full_pericope
    ":#{starting_verse} - #{ending_chapter_nr}:#{ending_verse}"
  end

  def same_chapter
    ":#{starting_verse} - #{ending_verse}"
  end

  def one_verse
    ":#{starting_verse}"
  end
end
