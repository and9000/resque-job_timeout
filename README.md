# resque-job_timeout

A [Resque](https://github.com/resque/resque) plugin. Requires Resque ~> 2.0.

Resque plugin allowing long-running jobs to automatically fail after a specified time.

![main](https://github.com/and9000/resque-job_timeout/actions/workflows/main.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/resque-job_timeout.svg)](https://badge.fury.io/rb/resque-job_timeout)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resque-job_timeout'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install resque-job_timeout

## Usage

Extend your job with this gem.

```ruby
require 'resque/job_timeout'

class ExampleJob
  extend Resque::Plugins::JobTimeout
  @queue = :example_queue

  def self.perform(*args)
    # magic goes here.
  end
end
```

## Configuration

Default timeout is 300 seconds. You can modify it by setting in your configuration

```ruby
Resque::Plugins::JobTimeout.timeout = 1.hour
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake` to run the tests. A running Redis exposed on `127.0.0.1:6379` is needed.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/and9000/resque-job_timeout.

## Credits

This gem has been inspired by [resque-timeout](https://github.com/jeffgran/resque-timeout) and [resque-retry](https://github.com/lantins/resque-retry).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
