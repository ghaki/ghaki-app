Gem::Specification.new do |s|

  s.name        = 'ghaki-app'
  s.summary     = 'Ghaki App singleton helpers'
  s.description = 'Ghaki App is a collection of application singleton libraries.'

  s.version = IO.read(File.expand_path('VERSION')).chomp
  s.required_rubygems_version = '>= 1.3.6'

  s.authors  = ['Gerald Kalafut']
  s.email    = 'gerald@kalafut.org'
  s.homepage = 'http://ghaki.com/'

  # gem dependencies
  s.add_development_dependency 'rspec', '>= 2.4.0'
  s.add_development_dependency 'rdoc',  '>= 3.9.4'
  s.add_development_dependency 'mocha', '>= 0.9.12'

  # rdoc setup
  s.has_rdoc = true
  s.extra_rdoc_files = ['README']

  # manifest
  s.files = Dir['{lib,bin}/**/*'] + %w{ README LICENSE }
  s.test_files = Dir['spec/**/*_spec.rb','*spec/**/*_helper.rb']

  s.require_path = 'lib'

end