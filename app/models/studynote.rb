class Studynote < ActiveRecord::Base
  has_many :pericopes, dependent: :destroy
  has_many :biblebooks, through: :pericopes
  has_many :roles, dependent: :delete_all

  belongs_to :author, class_name: "User"

  accepts_nested_attributes_for :pericopes

  validates :note,  presence: true
  validates :title, presence: true
end
