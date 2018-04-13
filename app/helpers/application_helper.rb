# frozen_string_literal: true

# Most generic helper class
module ApplicationHelper
  # Implements title method to give each webpage an appropriate title
  def title(*parts)
    return if parts.empty?
    content_for :title do
      (parts << t(:biblestudy_platform)).join(' - ')
    end
  end

  def timeago(time, options = {})
    options[:class] ||= 'timeago'
    return unless time
    content_tag(:time, time.to_s,
                options.merge(datetime: time.getutc.iso8601))
  end
end
