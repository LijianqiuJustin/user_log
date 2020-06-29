# UserLog
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'user_log'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install user_log
```
## Getting started
```ruby
rails generate user_logs:install MODEL
```

Example:
```ruby
rails generate user_logs:install UserLog
```
This creates:
* Config file `config/initializers/user_logs.rb`
* user_logs Model `app/models/user_log.rb`
* Migration `db/migrate/xxxxxxxx_create_user_logs.rb`
* UserLog Worker `app/workers/user_logs_worker.rb`

## Configuration

* Devise Users to track
```ruby
config.track_users = [:user, :admin_user, :manager]
```
* Save controllers params
```ruby
config.has_controller_params = true
```
* Save action params
```ruby
config.has_action_params = true
```
* Create browser uuid and session
```ruby
config.has_browser_uuid = true
```
* Enable Log on devise current_user not found
```ruby
config.log_nil_user = true
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
