# Metro Transit Next Bus CLI

A Ruby CLI for returning the departure time for the next bus or train for a given Metro Transit route, stop and direction.

Example Usage:
```
$ ./bin/nextbus "960" "State Fair" "East"
10 minutes
```

## Setup
### Requirements
* Ruby 2.3+
* Bundler
```
$ ruby -v
$ gem install bundler
```

### Install
Clone repo or download zip
```
$ cd nextbus
$ bundle install
$ ./bin/nextbus "960" "State Fair" "East"
```

## Tests
Tests are written using RSpec. See `/spec` directory for unit tests.
```
$ bundle exec rspec
```