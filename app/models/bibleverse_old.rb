# frozen_string_literal: true

# == Schema Information
#
# Table name: bibleverses
#
#  id         :bigint           not null, primary key
#  chapter    :integer
#  verse      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BibleverseOld
  include Comparable

  attr_reader :chapter, :verse

  def initialize(args)
    @chapter = args[:chapter]
    @verse = args[:verse]
  end

  # Spaceship to compare Verses
  def <=>(other)
    [chapter, verse] <=> [other.chapter, other.verse]
  end
end
