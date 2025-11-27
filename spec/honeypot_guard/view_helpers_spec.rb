require "honeypot_guard/view_helpers"

RSpec.describe HoneypotGuard::ViewHelpers do
  let(:lookup_context) do
    ActionView::LookupContext.new([])
  end

  let(:view) do
    ActionView::Base.new(lookup_context, {}, nil).tap do |v|
      v.extend HoneypotGuard::ViewHelpers
    end
  end

  describe "#spam_trap_fields" do
    it "renders a honeypot input and a timestamp field" do
      html = view.spam_trap_fields

      hp_name = HoneypotGuard.honeypot_field.to_s
      ts_name = HoneypotGuard.timestamp_field.to_s

      expect(html).to include("name=\"#{hp_name}\"")
      expect(html).to include("name=\"#{ts_name}\"")
      expect(html).to include("type=\"hidden\"")
    end
  end
end
