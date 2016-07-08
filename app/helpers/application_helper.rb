module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Biblestudy-platform").join(" - ")
      end
    end
  end
end
