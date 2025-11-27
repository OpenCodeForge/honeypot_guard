# frozen_string_literal: true

require "rails/railtie"

module HoneypotGuard
  class Railtie < Rails::Railtie
    initializer "honeypot_guard.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include HoneypotGuard::ViewHelpers
      end
    end
  end
end
