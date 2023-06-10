# frozen_string_literal: true

# == Schema Information
#
# Table name: studynotes
#
#  id         :integer          not null, primary key
#  note       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#
# Indexes
#
#  index_studynotes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#

# Models a Studynote, the main Object for this application
class Studynote < ApplicationRecord
  has_many :pericopes, inverse_of: :studynote, dependent: :destroy
  has_many :studynote_tags
  has_many :st_tags, through: :studynote_tags

  accepts_nested_attributes_for :pericopes,
                                allow_destroy: true,
                                reject_if: RejectDeeplyNested.blank?

  has_many :biblebooks, through: :pericopes
  has_many :roles, dependent: :delete_all

  belongs_to :author, class_name: "User"

  delegate :username, to: :author, prefix: true
  delegate :email, to: :author, prefix: true

  acts_as_taggable
  acts_as_taggable_on :tags

  # ActsAsTaggableOn.remove_unused_tags = true
  # ActsAsTaggableOn.force_lowercase = true

  validates :note, :title, presence: true
end
