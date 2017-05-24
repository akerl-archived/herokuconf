Gem::Specification.new do |s|
  s.name        = 'herokuconf'
  s.version     = '0.0.8'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.summary     = 'Configure local environment based on Heroku config variables'
  s.description = "Configure local environment based on Heroku config variables"
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/herokuconf'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split

  s.add_dependency 'netrc', '~> 0.11.0'
  s.add_dependency 'heroku-api', '~> 0.3.22'

  s.add_development_dependency 'rubocop', '~> 0.49.0'
  s.add_development_dependency 'rake', '~> 12.0.0'
  s.add_development_dependency 'coveralls', '~> 0.8.0'
  s.add_development_dependency 'rspec', '~> 3.6.0'
  s.add_development_dependency 'fuubar', '~> 2.2.0'
end
