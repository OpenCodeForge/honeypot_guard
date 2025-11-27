# frozen_string_literal: true

module HoneypotGuard
  module Controller
    extend ActiveSupport::Concern

    private

    # Usage:
    #
    #   class ContactMessagesController < ApplicationController
    #     include HoneypotGuard::Controller
    #     before_action :filter_spam, only: :create
    #   end
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
