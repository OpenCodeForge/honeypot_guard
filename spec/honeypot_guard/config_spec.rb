RSpec.describe HoneypotGuard do
  describe ".configure" do
    it "allows overriding configuration values" do
      begin
        original_delay = described_class.min_delay
        original_hp    = described_class.honeypot_field
        original_ts    = described_class.timestamp_field

        described_class.configure do |config|
          config.min_delay       = 5
          config.honeypot_field  = :website
          config.timestamp_field = :rendered_at
        end

        expect(described_class.min_delay).to eq(5)
        expect(described_class.honeypot_field).to eq(:website)
        expect(described_class.timestamp_field).to eq(:rendered_at)
      ensure
        # reset to sensible defaults so we don't leak between examples
        described_class.min_delay       = original_delay if original_delay
        described_class.honeypot_field  = original_hp if original_hp
        described_class.timestamp_field = original_ts if original_ts
      end
    end
  end
end
