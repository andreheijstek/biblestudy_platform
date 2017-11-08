# frozen_string_literal: true

module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << t(:biblestudy_platform)).join(' - ')
      end
    end
  end

  def admins_only
    yield if current_user.try(:admin?)
  end
end
