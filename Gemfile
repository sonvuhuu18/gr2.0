source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.4.2"

gem "rails", "~> 5.2.3"
gem "puma", "~> 4.3"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-sass", "~>3.4.1"
gem "jquery-rails"
gem "devise"
gem "cancancan"
gem "inherited_resources"
gem "activeadmin"
gem "formtastic"
gem 'ckeditor', github: 'galetahub/ckeditor'
gem "carrierwave"
gem "mini_magick"
gem "public_activity"
gem "redis"
gem "jquery-ui-rails"
gem "rails-assets-holderjs", source: "https://rails-assets.org"
gem "config"
gem "chartkick"
gem "faker", github: "stympy/faker"
gem "jquery-countdown-rails"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "sqlite3"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
