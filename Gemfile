source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in bunny-rails.gemspec.
gemspec

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  gem "puma"
  gem "sqlite3"

  gem 'rubocop'
end
