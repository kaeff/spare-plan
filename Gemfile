source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-rails'
  gem "compass-rails"
  gem "haml-rails"
  gem "haml_coffee_assets"
  gem "bootstrap-sass"

end

group :development do
  gem 'angularjs_scaffold'
  #gem 'coffee-rails-source-maps'
  gem 'ruby-bower', git: 'git@github.com:kaeff/ruby-bower.git'
  gem 'yaml_db'
end

group :test, :development do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "guard"
  gem "guard-rspec"
  gem "spork"
  gem 'rb-inotify', '~> 0.9', group: :linux
end

gem "inherited_resources"
gem "cancan"
gem "devise"
gem "simple_form"
gem "country_select"

# TODO Is there really a bug in ExecJS?
gem "execjs", git: 'git@github.com:kaeff/execjs.git', branch: 'json_api_error'
