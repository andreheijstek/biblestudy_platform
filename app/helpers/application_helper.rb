# frozen_string_literal: true

# Most generic helper class
# Implements title method to give each webpage an appropriate title
# and a filter for admin methods
module ApplicationHelper
  def title(*parts)
    return if parts.empty?
    content_for :title do
      (parts << t(:biblestudy_platform)).join(' - ')
    end
  end

  def admins_only
    yield if current_user.try(:admin?)
  end
end
