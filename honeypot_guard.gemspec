# frozen_string_literal: true

require_relative "lib/honeypot_guard/version"

Gem::Specification.new do |spec|
  spec.name        = "honeypot_guard"
  spec.version     = HoneypotGuard::VERSION
  spec.summary     = "Simple honeypot + delay spam guard for Rails controllers"
  spec.description = "Minimal Rails gem that injects honeypot fields in forms and provides a before_action returning 422 on spam."
  spec.authors     = ["OpenCodeForge"]
  spec.email       = ["contact@opencodeforge.com"]
  spec.homepage    = "https://github.com/OpenCodeForge/honeypot_guard"
  spec.license     = "MIT"

  spec.files = Dir["lib/**/*.rb"]

  spec.required_ruby_version = ">= 3.0"
  spec.add_dependency "rails", ">= 7.2", "< 9.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
