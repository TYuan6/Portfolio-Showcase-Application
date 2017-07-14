
source 'https://rubygems.org'

ruby '2.3.0'

gem 'jquery-turbolinks'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use Haml as the templating library
gem 'haml'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise', '4.2.0'
gem 'devise_security_extension'
gem 'rails_email_validator'
gem 'mail'
gem 'sendgrid-ruby'
gem 'tether-rails', "1.3.3"
gem 'bootstrap-sass', '~> 3.3.6'
gem "paperclip", "~> 5.0.0"
gem 'aws-sdk', '~> 2.3'
gem 'paperclip-av-transcoder'
gem "paperclip-ffmpeg", "~> 1.0.1"
gem "jquery-fileupload-rails"
gem 'youtube_it', '~> 2.4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'themoviedb'
#gem 'pg_search'

group :development do
   # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console' 
end
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'rspec-rails'
  gem 'guard-rspec'
  
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'simplecov', :require => false
  gem 'rspec-expectations'
  gem 'cucumber-rails', :require=>false
  gem 'capybara'
  gem 'database_cleaner'
end

group :production do
  gem 'pg' # for Heroku deployment
  gem 'rails_12factor'
end