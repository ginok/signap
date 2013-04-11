source "https://rubygems.org"

# Declare your gem's dependencies in signap.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'sass-rails',   '~> 4.0.0.beta1'
gem 'coffee-rails', '~> 4.0.0.beta1'
gem 'uglifier', '>= 1.0.3'
gem 'therubyracer'
gem 'haml'


gem 'mongoid', github: 'mongoid/mongoid', ref: '93284ce6e1f658c3f57076af9a8e5dce96082dbb'
gem 'bcrypt-ruby'

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'debugger'
  gem 'mongoid-rspec'
end
