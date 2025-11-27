# frozen_string_literal: true

require "honeypot_guard/version"
require "honeypot_guard/controller"
require "honeypot_guard/view_helpers"
require "honeypot_guard/railtie" if defined?(Rails::Railtie)

module HoneypotGuard
  class << self
    # Name of the honeypot field in params / forms
    attr_accessor :honeypot_field

    # Name of the timestamp field in params / forms
    attr_accessor :timestamp_field

    # Minimum delay (in seconds) between form rendering and submission
    attr_accessor :min_delay
  end

  # Defaults
  self.honeypot_field = :honeypot
  self.timestamp_field = :form_rendered_at
  self.min_delay = 3 # seconds

  # Optional configuration from Rails initializer
  #
  # HoneypotGuard.configure do |config|
  #   config.min_delay = 5
  #   config.honeypot_field = :website
  #   config.timestamp_field = :rendered_at
  # end
  #
  def self.configure
    yield self
  end
end
