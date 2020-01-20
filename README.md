# NationalParksExplorer

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/national_parks_explorer`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'national_parks_explorer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install national_parks_explorer

## Usage

You will need to acquire an API key from the NPS API at https://www.nps.gov/subjects/developer/get-started.htm, and assign it to a constant called NPS_API_KEY in a .env file. Hide that file using ruby gem 'dotenv'

Once you have added your API key:

Enter below into terminal and follow the prompts on screen. 

    $ ./bin/national_parks_explorer

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/national_parks_explorer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

