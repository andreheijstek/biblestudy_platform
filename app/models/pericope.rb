class Pericope < ActiveRecord::Base
  belongs_to :studynote
  belongs_to :biblebook
  validates_with PericopeValidator

  def bookname
    Biblebook.find(self.biblebook_id).name
  end
end

