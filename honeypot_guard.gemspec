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

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end

  spec.required_ruby_version = ">= 3.0"
  spec.add_dependency "rails", ">= 7.2", "< 9.0"
  spec.add_development_dependency "rspec", "~> 3.12"

  spec.metadata = {
    "source_code_uri" => "https://github.com/OpenCodeForge/honeypot_guard",
    "changelog_uri"   => "https://github.com/OpenCodeForge/honeypot_guard/blob/main/CHANGELOG.md"
  }
end
