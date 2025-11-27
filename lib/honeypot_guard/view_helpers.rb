# frozen_string_literal: true

require "action_view"

module HoneypotGuard
  # View helpers used to inject spam trap fields into Rails forms.
  #
  # This module provides helpers meant to be used in form views
  # and works in combination with the +filter_spam+ controller
  # method.
  #
  module ViewHelpers
    # Injects invisible spam trap fields into a form.
    #
    # This helper adds:
    # - a honeypot field that should stay empty
    # - a hidden timestamp used to detect fast submissions
    #
    # It must be used in combination with the
    # +filter_spam+ controller method.
    #
    # View example:
    #
    #   <%= form_with url: contact_messages_path do |f| %>
    #     <%= spam_trap_fields %>
    #     ...
    #   <% end %>
    #
    # Controller example:
    #
    #   class ContactMessagesController < ApplicationController
    #     include HoneypotGuard::Controller
    #     before_action :filter_spam, only: :create
    #   end
    #
    def spam_trap_fields
      hp = HoneypotGuard.honeypot_field
      ts = HoneypotGuard.timestamp_field

      honeypot_html = content_tag(
        :div,
        class: "hp-field",
        style: "position:absolute; left:-9999px; top:-9999px;"
      ) do
        label_tag(hp, "Leave this field empty") +
          text_field_tag(hp, nil, autocomplete: "off")
      end

      timestamp_html = hidden_field_tag(ts, Time.now.to_i)

      honeypot_html + timestamp_html
    end
  end
end
