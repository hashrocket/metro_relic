require 'metro_relic'

class Foo
  def bar
    "Hello World"
  end

  def self.baz
    "Hello Class World"
  end

end

class NoopLogger
  def log(message)
    # NOOP
  end
end

describe MetroRelic::Tracker do
  describe "#track" do
    it "sends all specified instance methods metrics to newrelic" do
      Foo.should_receive(:add_method_tracer).with(:bar, "Custom/MetroRelic/Foo#bar")
      MetroRelic::Tracker.new('spec/fixtures/metro.config', logger: NoopLogger.new).track
    end

    it "sends all specified class methods metrics to newrelic" do
      Foo.singleton_class.should_receive(:add_method_tracer).with(:baz, "Custom/MetroRelic/Foo.baz")
      MetroRelic::Tracker.new('spec/fixtures/metro.config', logger: NoopLogger.new).track
      Foo.baz
    end
  end
end
