source 'http://rubygems.org'

gem 'sinatra'

# just removed , '~> 4.2', '>= 4.2.6', :require => 'active_record' from below (the version)
gem 'activerecord'

# just removed , :require => 'sinatra/activerecord' (the version info)
gem 'sinatra-activerecord'

gem 'rake'
gem 'require_all'
# gem 'sqlite3', '~> 1.3.6'
# switching from sqlite to postgres in order to host on Heroku
gem 'pg'

gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem 'tux'
gem 'rack-flash3'
gem 'sinatra-flash'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
