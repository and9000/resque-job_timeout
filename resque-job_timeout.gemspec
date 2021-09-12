# frozen_string_literal: true

require_relative 'lib/resque/job_timeout/version'

Gem::Specification.new do |spec|
  spec.name          = 'resque-job_timeout'
  spec.version       = Resque::JobTimeout::VERSION
  spec.authors       = ['Andrea Lorenzetti']
  spec.email         = ['andrea@lorenzetti.me']

  spec.summary       = 'Resque plugin allowing long-running jobs to automatically fail after a specified time.'
  spec.homepage      = 'https://github.com/and9000/resque-job_timeout'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'resque', '~> 2.0'

  spec.add_development_dependency('byebug', '~> 11')
  spec.add_development_dependency('rake', '~> 13.0')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('rubocop', '~> 1.7')
  spec.add_development_dependency('rubocop-rake', '~> 0.6')
  spec.add_development_dependency('rubocop-rspec', '~> 2.0')
end
