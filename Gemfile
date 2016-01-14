source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'figaro'
gem 'rspotify'
gem 'hurley'
gem 'mocha'
# gem 'webmock'
# File: config/initializers/webmock.rb
# if Rails.env.test?
#   require 'webmock'
#   WebMock.disable_net_connect!(allow_localhost: true)
# end

group :development, :test do
  gem 'byebug'
  gem 'pry'
end

group :test do
  gem 'vcr'
  gem 'simplecov', :require => false
end

group :development do
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'rails_12factor'
end
