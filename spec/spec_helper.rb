# frozen_string_literal: true

dir = File.dirname(File.expand_path(__FILE__))

require 'byebug'

require 'test_helper'
require 'resque/job_timeout'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.expose_dsl_globally = true

  config.before(:suite) do
    if ENV['CI'] == 'true'
      config.formatter = :documentation

      Resque.redis = '127.0.0.1:6379'
    else
      # make sure we can run redis-server
      unless system('hash redis-server')
        puts '', '** `redis-server` was not found in your PATH'
        abort ''
      end

      # make sure we can shutdown the server using cli
      unless system('hash redis-cli')
        puts '', '** `redis-cli` was not found in your PATH'
        abort ''
      end

      `redis-server #{dir}/redis-test.conf`
      Resque.redis = '127.0.0.1:9736'

      # wait 5 seconds until redis is up
      5.times do
        break if system('redis-cli -p 9736 info server > /dev/null 2>&1')

        sleep 1
      end
    end
  end

  config.after(:suite) do
    `redis-cli -p 9736 shutdown nosave` if ENV['CI'] == 'true' && (ENV['CI'] != 'true')
  end
end
