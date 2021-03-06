# CsvCellSanitizers

Light and extendable module for standard CSV ruby library to help you protect
the output against different attack vectors such as "Excel Macro Injection"
See https://www.owasp.org/index.php/CSV_Excel_Macro_Injection

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_cell_sanitizers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_cell_sanitizers

## Usage

```ruby

CSV.generate do |csv|
	csv.extend(CsvCellSanitizers::ExcelInjection)

	csv << ['=3+4', '=second']
end # => "'=3+4,'=second\n"

```
Please refer to tests to see different and more advance usages.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keram/csv_cell_sanitizers. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CsvCellSanitizers project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/keram/csv_cell_sanitizers/blob/master/CODE_OF_CONDUCT.md).
