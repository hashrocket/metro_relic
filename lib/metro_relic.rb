require "metro_relic/version"
require 'newrelic_rpm'

module MetroRelic
  class Logger
    def log(message)
      puts(message)
    end
  end
end

module MetroRelic
  class RailsLogger
    def log(message)
      Rails.logger.warn(message)
    end
  end
end

module MetroRelic
  class Tracer
    attr_reader :method

    def initialize(method)
      @method = method
    end

    def trace!
      if instance_method?
        klass.send(:include, NewRelic::Agent::MethodTracer)
        klass.add_method_tracer(name, metric)
      elsif class_method?
        klass.singleton_class.send(:include, NewRelic::Agent::MethodTracer)
        klass.singleton_class.add_method_tracer(name, metric)
      end
    end

  private

    def metric
      "Custom/MetroRelic/#{method}"
    end

    def klass
      @klass ||= Object.const_get(method.split(/(?=\#|\.)/)[0])
    end

    def raw_name
      @raw_name ||= method.split(/(?=\#|\.)/)[1]
    end

    def name
      @name ||= raw_name[1..-1].to_sym
    end

    def instance_method?
      raw_name[0] == "#"
    end

    def class_method?
      raw_name[0] == "."
    end
  end
end

module MetroRelic
  class Tracker
    attr_reader :method_list, :logger

    def initialize(path, options={})
      @logger = options[:logger] || Logger.new()
      self.path = path
    end

    def track
      method_list.each do |method|
        begin
          Tracer.new(method).trace!
          logger.log("Added new relic monitoring to #{method}")
        rescue
          logger.log("Could not add MetroRelic tracking to #{method}")
          raise NoMethodError.new
        end
      end
    end

    private

    def path=(path)
      @method_list = File.read(path).split(/\n+/)
    end

  end
end
