# frozen_string_literal: true

module HoneypotGuard
  module ViewHelpers
    # Usage inside a form_with / form_for block:
    #
    # <%= form_with url: contact_messages_path do |f| %>
    #   <%= spam_trap_fields %>
    #   ...
    # <% end %>
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
