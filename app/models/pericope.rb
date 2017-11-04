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
  # attr_accessor :name

  belongs_to :studynote
  belongs_to :biblebook

  validates :name, presence: true
  validates_with PericopeValidator

  def initialize(attributes={})
    super
    unless attributes.empty?
      @name = attributes[:name]
    end
    self
  end

end
