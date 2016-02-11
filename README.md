# TimePieces

This gem is for managing time pieces.  It lets you add and subtract durations to help you with scheduling.  For example if you have a duration (9:00am - 5:00pm) and you subtract the duration (1:00pm - 2:00pm) it will result in a time set with 2 time duration of (9:00am - 1:00pm) and (2:00pm - 5:00pm).  You can also add durations.  To make an object into a duration just use.  You also have to include the method duration_copy which is used when creating new objects, for example when a duration is split.
```ruby
include TimePieces::Duration

def duration_copy
    return self.clone
end

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'time_pieces'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_pieces

<!---
## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
-->
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/riggleg/time_pieces


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

