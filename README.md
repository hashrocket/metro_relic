# MetroRelic

## Installation

Add this line to your application's Gemfile:

    gem 'metro_relic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metro_relic

## Initialization

```ruby
MetroRelic::Tracker.new('path/to/config_file').track
```

You can also log the methods that fail to load:

```ruby

class CustomLogger

  def log(message)
    # do something with message
  end

end

MetroRelic::Tracker.new('path/to/config_file', logger: CustomLogger.new).track

```


## Implementation
In your config file, you can track:

### Class methods
Track class methods with `<class>.<method_name>`

Example:

```
Foo.bar
Baz.bux
```

**and**

### Instance methods
Track instance methods with `<class>.<method_name>`

Example:

```
Foo#bar
Baz#bux
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
