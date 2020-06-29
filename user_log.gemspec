# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'user_log/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = 'user_log'
  spec.version       = UserLogs::VERSION
  spec.authors       = ['Jianqiu']
  spec.email         = ['justin.li@pixelforcesystems.com.au']

  spec.summary       = 'Track User Log Module'
  spec.description   = 'Track User Log Module'
  spec.homepage      = ''
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 5.2.4', '>= 5.2.4.3'
  spec.add_dependency 'devise'
  spec.add_dependency 'exception_notification'
  spec.add_dependency 'pg'
  spec.add_dependency 'sidekiq'
  spec.add_dependency 'redis-rails'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sidekiq', '~> 5.0.4'
  spec.add_development_dependency 'generator_spec'
end
