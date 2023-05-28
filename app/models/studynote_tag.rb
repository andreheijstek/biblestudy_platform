# == Schema Information
#
# Table name: studynote_tags
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  st_tag_id    :bigint
#  studynote_id :bigint
#
# Indexes
#
#  index_studynote_tags_on_st_tag_id     (st_tag_id)
#  index_studynote_tags_on_studynote_id  (studynote_id)
#
# Foreign Keys
#
#  fk_rails_...  (st_tag_id => st_tags.id)
#  fk_rails_...  (studynote_id => studynotes.id)
#
class StudynoteTag < ApplicationRecord
  belongs_to :studynote
  belongs_to :st_tag
end
