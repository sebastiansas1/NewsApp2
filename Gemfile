source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.7'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rubocop', '~> 0.55.0', require: false
gem 'sass-rails', '>= 3.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Custom Gems
gem 'acts_as_votable', '~> 0.11.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'chartkick', '~> 2.3', '>= 2.3.4'
gem 'descriptive_statistics', '~> 2.4.0', require: 'descriptive_statistics/safe'
gem 'devise'
gem 'groupdate'
gem 'httparty', '~> 0.16.2'
gem 'jquery-rails'
gem 'paperclip', '~> 6.0'
gem 'sass', '~> 3.5', '>= 3.5.6'
gem 'simple_form', '~> 3.5', '>= 3.5.1'
gem 'sprockets-rails', '~> 3.2', '>= 3.2.1'
gem 'yaml_db'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'annotate', '~> 2.7', '>= 2.7.2'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
