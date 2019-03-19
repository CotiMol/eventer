source 'http://rubygems.org'
ruby '2.1.8'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'pdf-inspector', :require => "pdf/inspector"
  gem 'rspec-mocks'
  gem 'simplecov', '~> 0.7.1'
  gem 'coveralls', require: false
  gem "chromedriver-helper"
  gem 'debase'
  gem 'ruby-debug-ide'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails',require: false
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'shoulda-matchers'
  #gem 'selenium-webdriver', '~> 3.4.0' -> for testing in mac
  gem 'selenium-webdriver', '~> 2.53.4'
end

group :production do
  gem 'pg'
  gem 'thin'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'execjs'
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'

# Gemas para idetificación y autorización de usuarios
gem 'devise', '3.1.0'
gem 'cancan'

gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'valid_email'
gem 'daemons'
gem 'delayed_job_active_record'
gem 'comma'
gem 'money'
gem 'prawn'
gem 'prawn_rails'
gem 'dimensions' # knowing the heigt of an image
gem 'redcarpet'

# Gemas necesarias para la comunicación con CapsuleCRM
gem 'curb'

# Edición en el lugar
gem 'best_in_place'

# Amazon AWS API Client
gem 'aws-sdk'

# App Monitoring Heroku Plug-In
gem 'newrelic_rpm'

# Gemas necesarias para integracion con mailchimp workflow
gem 'httparty'
gem 'json'
#gem 'digest'

#reCaptcha
gem "recaptcha", require: "recaptcha/rails"  #, :github => "ambethia/recaptcha"

## Gemfile for Rails 3+, Sinatra, and Merb
gem 'will_paginate', '~> 3.1.0'
