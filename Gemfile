source 'https://rubygems.org'

gem 'rails', '5.0.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'pg'
gem 'simple_form'
gem 'sorcery'
gem 'validates_email_format_of'
gem 'carrierwave'
gem 'carrierwave-i18n'
gem 'mini_magick'
gem "fog-aws"
gem 'damerau-levenshtein'
gem 'whenever', require: false
gem 'http_accept_language'
gem 'rails-i18n', '~> 4.0.0'
gem 'rollbar'
gem 'newrelic_rpm'
gem 'dotenv-rails', :groups => [:development, :test, :production]
gem 'remotipart', github: 'mshibuya/remotipart'
gem 'rails_admin', '>= 1.0.0.rc'

group :production do
  gem 'puma'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'nokogiri'
  gem 'rubocop'
  gem 'pry-rails'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem "codeclimate-test-reporter", require: nil
end
