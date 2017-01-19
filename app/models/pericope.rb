class Pericope < ActiveRecord::Base
  belongs_to :studynote
  belongs_to :biblebook
  default_scope { order("sequence ASC") }

  validates :name, presence: true
  validates_with PericopeValidator

  def bookname
    Biblebook.find(self.biblebook_id).name
  end
end

