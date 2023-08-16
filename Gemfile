source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.6"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker'
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'rack-test'
end

gem "vite_rails"
gem "vite_ruby"
gem "ruby-vips", "~> 2.1", ">= 2.1.4"
gem "annotate", group: :development
gem 'rack-attack'