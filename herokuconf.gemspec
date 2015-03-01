Gem::Specification.new do |s|
  s.name        = 'herokuconf'
  s.version     = '0.0.7'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.summary     = 'Configure local environment based on Heroku config variables'
  s.description = "Configure local environment based on Heroku config variables"
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/herokuconf'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split

  s.add_dependency 'netrc', '~> 0.10.2'
  s.add_dependency 'heroku-api', '~> 0.3.22'

  s.add_development_dependency 'rubocop', '~> 0.28.0'
  s.add_development_dependency 'rake', '~> 10.4.0'
  s.add_development_dependency 'coveralls', '~> 0.7.1'
  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'fuubar', '~> 2.0.0'
end
