# frozen_string_literal: true

# Component to render an item in the nav-bar
class NavItemComponent < ViewComponent::Base
  def initialize(text:, link:, id:)
    super
    @text = text
    @link = link
    @id = id
  end
  def call
    tag.li(class: %w[nav-item]) do
      link_to @text, @link, class: "nav-link", id: @id
    end
  end
end
