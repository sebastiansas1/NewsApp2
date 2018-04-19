source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.7'

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '>= 3.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# Custom Gems
gem 'simple_form', '~> 3.5', '>= 3.5.1'
gem 'sprockets-rails', '~> 3.2', '>= 3.2.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'jquery-rails'
gem 'sass', '~> 3.5', '>= 3.5.6'
gem 'devise'
gem 'paperclip', '~> 6.0'
gem 'acts_as_votable', '~> 0.11.1'
gem 'httparty', '~> 0.16.2'
gem 'chartkick', '~> 2.3', '>= 2.3.4'
gem 'groupdate'
gem 'yaml_db'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate', '~> 2.7', '>= 2.7.2'
end

group :production do 
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
