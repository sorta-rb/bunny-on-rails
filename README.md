# BunnyOnRails
Bunny adapter for Rails enabling you to create in-process AMQP consumers and producers

## Usage
```sh
$ bin/rails generate bunny foo
```
This will create a service scaffold in `app/services/foo_service.rb` and add it's initializer
to `config/application.rb` `after_initialize` block.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'bunny-on-rails'
```

And then execute:
```sh
$ bundle
$ bundle exec rails generate bunny:install
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
