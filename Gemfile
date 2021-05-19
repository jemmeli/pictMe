source 'https://rubygems.org'
require 'rubygems'
ruby '2.5.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'pg', '~> 0.18.4' # Postgres SQL
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.5'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'redis', '~> 3.3.3'
gem 'puma', '~> 5.3.1'#3.7.1
gem 'imgkit', '~> 1.6.1'
gem 'wkhtmltoimage-binary', '~> 0.12.2'
gem 'aws-sdk', '~> 2.3.0'
gem 'httparty'
gem 'newrelic_rpm'
gem 'charlock_holmes'
gem 'bitly', '~> 0.10.4'
#sidekiq use redis as a job management store to process thousands of jobs per second.
gem 'sidekiq' #gestionnaire de tâche de fond/background job framework
gem 'sinatra', :require => false #for sidekiq
gem 'sidekiq-scheduler' # planificateur de tâche pr Sidekiq
gem 'simple_form'
gem 'stripe'
gem "paperclip", "~> 5.0.0"



gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
git_source(:github){ |repo_name| "https://github.com/#{repo_name}.git" }
gem 'remotipart', github: 'jbox-web/remotipart', tag: '1.6.0'
gem 'gon'
gem 'mailjet'
#
gem "shrine", "~> 2.3.1"
#gem 'aws-sdk', "~> 3"
gem 'roda', "~> 2.29.0"
gem 'jquery-fileupload-rails'
#gem 'bootstrap-sass'
gem 'hirb'
#gem 'jquery-rails'




gem 'rack-cors', :require => 'rack/cors'
gem 'rollbar' # reporting des erreurs
gem 'bootstrap-sass'
gem "bootstrap-switch-rails", '3.3.3'
gem 'htmlentities' # permet de transformer les accents en entités HTML ex: &eacute;
gem 'htmlcompressor' # permet de compresser le HTML  des widgets
gem 'will_paginate-bootstrap' # pagination
gem 'google_url_shortener'
gem 'google-cloud-vision', '~> 0.31.0'
gem 's3_direct_upload'
gem 'slim'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'money-rails'
gem 'open_uri_redirections'
gem 'kaminari'
gem 'geocoder'
gem 'enumerize'
gem 'rebrandly'

gem 'doorkeeper', '~> 4.2.6'
gem 'active_model_serializers', '~> 0.10.7'

gem 'blueprinter'
gem 'oj'



group :development, :test do
  gem 'pry-rails'
  gem 'byebug'
  gem 'minitest-rails'
  gem 'dotenv-rails', '~> 2.1.1' # parsing du fichier ENV en dev important
  #gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'minitest-rails-capybara'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-minitest'
  gem 'timecop'
  gem 'ffaker'
  #gem 'factory_girl_rails'
  gem "factory_bot"
  gem 'rspec-rails'
  gem 'rspec_api_documentation'
  gem 'shoulda-matchers'
end


#========================================
#===Very Important to work on Heroku=====
#========================================
group :production do
  gem 'dotenv-rails', '~> 2.1.1' # parsing du fichier ENV en dev
  gem 'puma', '~> 5.3.1'#3.7.1
end

group :development do
  gem 'annotate'
  gem "letter_opener_web"
  gem 'rubocop', require: false
  gem "rubycritic", require: false
end

group :test do
  gem 'database_cleaner'
  gem 'dox', require: false
end
