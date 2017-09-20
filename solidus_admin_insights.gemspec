Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_admin_insights'
  s.version     = '2.1.1'
  s.summary     = "Dashboard for querying and viewing you solidus store's metrics"
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 2.1.0'

  s.author    =  ["Nimish Mehta", "Tanmay Sinha", "Nimish Gupta", "+ Vinsol Team"]
  s.email     = 'info@vinsol.com'
  s.homepage  = 'http://vinsol.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  solidus_version = '~> 2.1'

  s.add_dependency 'solidus_core', solidus_version
  s.add_dependency 'solidus_events_tracker', '>= 2.1.1'

  s.add_development_dependency 'shoulda-matchers', '~> 2.6.2'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'solidus_backend'
  s.add_development_dependency 'capybara', '~> 2.5'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker',  '~> 2.2.0'
  s.add_development_dependency 'rspec-rails',  '~> 3.4'
  s.add_development_dependency 'sass-rails', '~> 5.0.0'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2', '~> 0.4.0'
  s.add_development_dependency 'pg', '~> 0.18.0'
  s.add_development_dependency 'chartkick', '~> 1.4.0'

  s.add_dependency 'wicked_pdf', '~> 1.0.6'
  s.add_dependency 'wkhtmltopdf-binary', '~> 0.12.3.1'
end
