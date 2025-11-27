require "honeypot_guard/controller"

RSpec.describe HoneypotGuard::Controller do
  # Dummy class to include the concern and test its internal logic
  let(:dummy_class) do
    Class.new do
      include HoneypotGuard::Controller
    end
  end

  let(:instance) { dummy_class.new }

  describe "#spam_detected?" do
    around do |example|
      original_delay = HoneypotGuard.min_delay
      HoneypotGuard.min_delay = 3
      example.run
    ensure
      HoneypotGuard.min_delay = original_delay
    end

    it "returns true when honeypot is filled" do
      expect(instance.send(:spam_detected?, "bot", Time.now.to_i.to_s)).to be true
    end

    it "returns false when honeypot is empty and timestamp is old enough" do
      ts = (Time.now.to_i - 10).to_s
      expect(instance.send(:spam_detected?, "", ts)).to be false
    end

    it "returns true when submission is too fast" do
      ts = Time.now.to_i.to_s
      expect(instance.send(:spam_detected?, "", ts)).to be true
    end

    it "returns false when timestamp is blank" do
      expect(instance.send(:spam_detected?, "", nil)).to be false
      expect(instance.send(:spam_detected?, "", "")).to be false
    end

    it "returns false when timestamp is invalid" do
      expect(instance.send(:spam_detected?, "", "not-a-number")).to be false
    end
  end
end
