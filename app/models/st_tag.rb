# == Schema Information
#
# Table name: st_tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class StTag < ApplicationRecord
  has_many :studynote_tags
  has_many :studynotes, through: :studynote_tags
end
