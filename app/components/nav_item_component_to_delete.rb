# frozen_string_literal: true

# Component to render an item in the nav-bar
class NavItemComponentToDelete < ViewComponent::Base
  def initialize(text:, link:)
    super
    @text = text
    @link = link
  end
  def call
    tag.li(class: %w[nav-item]) do
      link_to @text, @link, class: "nav-link", method: :delete
    end
  end
end
