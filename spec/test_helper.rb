# frozen_string_literal: true

require_relative 'test_job'

def process_test_job(worker, seconds)
  Resque.enqueue(TestJob, seconds)

  worker.perform(worker.reserve)
  worker.done_working
end
