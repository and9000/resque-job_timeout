# frozen_string_literal: true

require 'timeout'

module Resque
  module Plugins
    # TODO: document me.
    #
    module JobTimeout
      def self.timeout
        @timeout ||= 300
      end

      def self.timeout=(timeout)
        @timeout = timeout
      end

      def around_perform_with_job_timeout(*_args, &block)
        ::Timeout.timeout(Resque::Plugins::JobTimeout.timeout, &block)
      end
    end
  end
end
