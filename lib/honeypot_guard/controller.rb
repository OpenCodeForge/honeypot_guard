# frozen_string_literal: true

module HoneypotGuard
  # Controller helpers used to filter out simple spam submissions.
  #
  # This module is intended to be included in Rails controllers
  # handling form submissions, and works in combination with the
  # +spam_trap_fields+ view helper.
  #
  module Controller
    extend ActiveSupport::Concern

    private

    # Filters out obvious spam submissions based on:
    #
    # - a honeypot field that must remain empty
    # - a minimum delay between form render and submission
    #
    # Typical usage in a controller:
    #
    #   class ContactMessagesController < ApplicationController
    #     include HoneypotGuard::Controller
    #
    #     before_action :filter_spam, only: :create
    #   end
    #
    # Combined with the ViewHelpers:
    #
    #   <%= form_with model: @contact_message do |f| %>
    #     <%= spam_trap_fields %>
    #     ...
    #   <% end %>
    #
    # Behaviour:
    # - reads the configured honeypot and timestamp fields from +params+
    # - if spam is detected, logs a message and responds with <tt>422 Unprocessable Entity</tt>
    # - the controller action is not executed in that case
    #
    def filter_spam
      hp_name = HoneypotGuard.honeypot_field.to_s
      ts_name = HoneypotGuard.timestamp_field.to_s

      honeypot = params[hp_name]
      timestamp = params[ts_name]

      if spam_detected?(honeypot, timestamp)
        Rails.logger.info "[HoneypotGuard] Blocked spam from #{request.remote_ip}"
        head :unprocessable_entity
      end
    end

    def spam_detected?(honeypot, timestamp)
      # 1) Honeypot field must stay empty
      return true if honeypot.present?

      # 2) Check minimal delay
      return false if timestamp.blank?

      ts = Integer(timestamp) rescue nil
      return false unless ts

      delay = Time.now.to_i - ts
      delay < HoneypotGuard.min_delay.to_i
    end
  end
end
