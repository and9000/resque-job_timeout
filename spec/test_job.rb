# frozen_string_literal: true

require 'resque/job_timeout'

class TestJob
  extend Resque::Plugins::JobTimeout

  @queue = :testing

  def self.perform(seconds)
    1.upto seconds do
      sleep(1)
    end
  end
end
