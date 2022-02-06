# Ruby2d::Tiled

A library to import LDTK worlds and levels into your [Ruby2D](https://www.ruby2d.com/) applications.

## Installation

Install the gem on your comamnd line:

    $ gem install ruby2d-tiled

## Usage

Here is a small example of using the library in your ruby2d application:

```ruby
require 'ruby2d'
require 'ruby2d/tiled'

world = Ruby2d::Tiled::LDTK.load('/path/to/ldtk/file')

world.show

show
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mariovisic/ruby2d-tiled. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mariovisic/ruby2d-tiled/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby2d::Tiled project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mariovisic/ruby2d-tiled/blob/master/CODE_OF_CONDUCT.md).
