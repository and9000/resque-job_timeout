# frozen_string_literal: true

describe Resque::JobTimeout do
  before do
    Resque.redis.redis.flushall
    @worker = Resque::Worker.new(:testing)
    @worker.register_worker
  end

  it 'resque plugin lint' do
    expect(Resque::Plugin.lint(Resque::Plugins::JobTimeout)).to be_truthy
  end

  it 'has a default config' do
    expect(Resque::Plugins::JobTimeout.timeout).to be(300)
  end

  it 'kills long running job' do
    Resque::Plugins::JobTimeout.timeout = 1

    process_test_job(@worker, 60)

    expect(Resque.info[:pending]).to eq(0)
    expect(Resque.info[:processed]).to eq(1)
    expect(Resque.info[:failed]).to eq(1)
  end

  it 'does not kill if job completes in time' do
    Resque::Plugins::JobTimeout.timeout = 5

    process_test_job(@worker, 1)

    expect(Resque.info[:pending]).to eq(0)
    expect(Resque.info[:processed]).to eq(1)
    expect(Resque.info[:failed]).to eq(0)
  end
end
