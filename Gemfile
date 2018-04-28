ruby "2.5.1"
source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.2.0"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "awesome_print"
gem "rollbar"
gem "pg"
gem "data_migrate"
gem "bootstrap", "~> 4.0.0"
gem "jquery-rails"
gem "friendly_id", "~> 5.1.0"
gem "redcarpet", "~> 3.4.0"
gem "valid_email2"
gem "bootsnap", require: false
gem "stripe"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "database_cleaner"
  gem "rspec-rails"
  gem "brakeman"
  gem "bullet"
  gem "coveralls", require: false
  gem "faker"
end

group :test do
  gem "shoulda-matchers", "~> 3.1"
  gem "factory_bot_rails"
  gem "simplecov", require: false
  gem "rails-controller-testing"
  gem "capybara"
  gem "selenium-webdriver"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "dotenv-rails"
  gem "better_errors"
  gem "letter_opener"
end
